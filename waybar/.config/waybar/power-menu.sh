#!/usr/bin/env bash
set -euo pipefail

# Choose your launcher: wofi, rofi, or fuzzel. Uncomment one.
LAUNCHER="rofi"

prompt_menu() {
  case "$LAUNCHER" in
    wofi)
      # -dmenu style; tweak style via ~/.config/wofi/ if desired
      wofi --dmenu --prompt "Select action" \
        --hide-scroll \
        --insensitive
      ;;
    rofi)
      rofi -dmenu -p "Select action"
      ;;
    fuzzel)
      fuzzel --dmenu --prompt "Select action"
      ;;
    *)
      echo "Invalid LAUNCHER" >&2
      exit 1
      ;;
  esac
}

# Menu entries (first token is the action key)
# You can add icons or text as you like.
choices=$(cat <<'EOF'
reload_waybar  Reload Waybar
restart_waybar Restart Waybar (kill + start)
suspend        Suspend
hibernate      Hibernate
shutdown       Power Off
reboot         Reboot
lock           Lock
quit_hyprland  Quit Hyprland
cancel         Cancel
EOF
)

selection="$(printf "%s\n" "$choices" | prompt_menu | awk '{print $1}')"
[ -z "${selection:-}" ] && exit 0  # user cancelled

# Helper: start waybar if not running (for manual launches)
start_waybar_if_needed() {
  if ! pgrep -x waybar >/dev/null 2>&1; then
    nohup waybar >/tmp/waybar.log 2>&1 &
  fi
}

case "$selection" in
  reload_waybar)
    pkill -SIGUSR2 waybar
    ;;
  restart_waybar)
    pkill waybar || true
    # If you manage via systemd --user, prefer:
    # systemctl --user restart waybar.service && exit 0
    start_waybar_if_needed
    ;;
  suspend)
    # Hyprland-friendly suspend; lock first if you use a locker
    # hyprlock & sleep 0.3
    systemctl suspend
    ;;
  hibernate)
    systemctl hibernate
    ;;
  shutdown)
    systemctl poweroff
    ;;
  reboot)
    systemctl reboot
    ;;
  lock)
    # Requires hyprlock or your preferred locker
    hyprlock
    ;;
  quit_hyprland)
    # Cleanly exit Hyprland session
    hyprctl dispatch exit
    ;;
  cancel|*)
    ;;
esac

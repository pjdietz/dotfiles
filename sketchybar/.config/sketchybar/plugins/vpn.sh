#!/bin/sh

VPN=AZURE_VLAN_001

# Update the sketchybar item.
draw()
{
  sketchybar --set "${NAME}" \
    icon="${ICON}" \
    icon.font.size="30" \
    label="VPN"
}

# Toggle the VPN; set the icon to show the progress indicator.
click()
{
  status=$(networksetup -showpppoestatus "${VPN}")
  if [ "${status}" = "connected" ]; then
    networksetup -disconnectpppoeservice "${VPN}"
  else
    networksetup -connectpppoeservice "${VPN}"
  fi
  ICON=󰦖
  draw
}

# Update the icon based on the VPN status.
status()
{
  status=$(networksetup -showpppoestatus "${VPN}")
  case "${status}" in
    "connected") ICON=
      ;;
    "disconnected") ICON=
      ;;
    "connecting"|"disconnecting") ICON=󰦖
      ;;
    *) ICON=󰀨
      ;;
  esac
  draw
}

if [ "$1" = "click" ]; then
  click
else
  status
fi

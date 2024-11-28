#!/usr/bin/env bash

ICON_APP=󰣆 # fallback app
ICON_CALENDAR=
ICON_DATABASE=
ICON_FIREFOX=
ICON_FINDER=󰀶
ICON_TEAMS=󰊻
ICON_TERMINAL= # fallback terminal app, terminal, warp, iterm2
ICON_TODO=
ICON_VPN=󰒄

case "$1" in
"Alacritty")
  echo $ICON_TERMINAL;;
"Azure VPN Client")
  echo $ICON_VPN;;
"DataGrip")
  echo $ICON_DATABASE;;
"Finder")
  echo $ICON_FINDER;;
"Firefox")
  echo $ICON_FIREFOX;;
"Microsoft Outlook")
  echo $ICON_CALENDAR;;
"Microsoft Teams")
  echo $ICON_TEAMS;;
"Todoist")
  echo $ICON_TODO;;
*)
  echo $ICON_APP;;
esac








export ICON_CMD=󰘳
export ICON_COG=󰒓 # system settings, system information, tinkertool
export ICON_CHART=󱕍 # activity monitor, btop
export ICON_LOCK=󰌾
export ICON_APP=󰣆 # fallback app
export ICON_DOCUMENTS=󰈙 # powerpoint

export ICON_PACKAGE=󰏗 # brew
export ICON_DEV=󰅨 # nvim, xcode, vscode
export ICON_VSCODIUM= # nvim, xcode, vscode
export ICON_FILE=󰉋 # ranger, finder
export ICON_FINDER=󰀶
export ICON_GIT=󰊢 # lazygit
export ICON_TODO= # taskwarrior, taskwarrior-tui, reminders, onenote
export ICON_SCREENSAVOR=󱄄 # unimatrix, pipe.sh
export ICON_WEATHER=󰖕 # weather
export ICON_MAIL= # mail, outlook
export ICON_CALC=󰪚 # calculator, numi
export ICON_MAP=󰆋 # maps, find my
export ICON_MICROPHONE=󰍬 # voice memos
export ICON_CHAT=󰻞 # messages, slack, teams, telegram
export ICON_VIDEOCHAT=󰍫 # facetime, zoom, webex
export ICON_NOTE=󱞎 # notes, textedit, stickies, word, bat
export ICON_CAMERA=󰄀 # photo booth
export ICON_WEB=󰇧 # safari, beam, duckduckgo, arc, edge, chrome, firefox
export ICON_HOMEAUTOMATION=󱉑 # home
export ICON_PODCAST=󰦔 # podcasts
export ICON_PLAY=󱉺 # tv, quicktime, vlc
export ICON_BOOK=󰂿 # books
export ICON_BOOKINFO=󱁯 # font book, dictionary
export ICON_PREVIEW=󰋲 # screenshot, preview
export ICON_PASSKEY=󰷡 # 1password
export ICON_DOWNLOAD=󱑢 # progressive downloader, transmission
export ICON_CAST=󱒃 # airflow
export ICON_TABLE=󰓫 # excel
export ICON_PRESENT=󰈩 # powerpoint
export ICON_CLOUD=󰅧 # onedrive
export ICON_PEN=󰏬 # curve
export ICON_REMOTEDESKTOP=󰢹 # vmware, utm
export ICON_CLOCK=󰥔 # clock, timewarrior, tty-clock
export ICON_CALENDAR=󰃭 # calendar
export ICON_WIFI=󰖩
export ICON_WIFI_OFF=󰖪
export ICON_VPN=󰦝 # vpn, nordvpn
export ICONS_VOLUME=(󰸈 󰕿 󰖀 󰕾)
export ICONS_BATTERY=(󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
export ICONS_BATTERY_CHARGING=(󰢟 󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
export ICON_SWAP=󰁯
export ICON_RAM=󰓅
export ICON_DISK=󰋊 # disk utility
export ICON_CPU=󰘚
export ICON_CONTROLCENTER=􀜊

# My apps
export ICON_DISCORD= # Discord
export ICON_TERM= # fallback terminal app, terminal, warp, iterm2
export ICON_PHOTOSHOP=
export ICON_AFTEREFFECTS=󱁑
export ICON_INDESIGN=󰴑
export ICON_ILLUSTRATOR=
export ICON_PHOTOS=
export ICON_FIGMA=
export ICON_KICAD=
export ICON_REMINDERS=
export ICON_DOWNLOAD=􁾮 # Jdownloader2
export ICON_ICON=􀼱 # SF Symbols
export ICON_STEAM=󰓓 # Steam
export ICON_HANDBRAKE=󱁆
export ICON_FIREFOX=󰈹
export ICON_FONTBOOK=
export ICON_GLM=󰓃
export ICON_POPCORN=􁐈
export ICON_DAISYDISK=󰞯

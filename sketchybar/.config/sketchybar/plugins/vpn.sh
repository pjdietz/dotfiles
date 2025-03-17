#!/bin/sh

VPN=AZURE_VLAN_001

click()
{
  status=$(networksetup -showpppoestatus "${VPN}")
  if [ "${status}" = "connected" ]; then
    networksetup -disconnectpppoeservice "${VPN}"
  else
    networksetup -connectpppoeservice "${VPN}"
  fi
  ICON=󰦖
  sketchybar --set "${NAME}" icon="${ICON}" label=""
}

status()
{
  status=$(networksetup -showpppoestatus "${VPN}")
  case "${status}" in
    "connected") ICON=󰱓
      ;;
    "disconnected") ICON=󰅛
      ;;
    "connecting") ICON=󰦖
      ;;
    *) ICON=󰛵
      ;;
  esac
  sketchybar --set "${NAME}" icon="${ICON}" label=""
}

if [ "$1" = "click" ]; then
  click
else
  status
fi

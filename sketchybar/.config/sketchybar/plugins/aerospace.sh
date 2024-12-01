#!/usr/bin/env bash

label=
drawing=off
background_color=0x0fffffff

apps=$(aerospace list-windows --workspace "$1" --format '%{app-name}' | sort -u)
if [ -n "${apps}" ]; then

  # Draw whenever the workspace has at least one app.
  drawing=on

  # Hightlight the focused workspace.
  focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
  if [ "$1" = "${focused}" ]; then
    background_color=0x33ffffff
  fi

  # Show app icons.
  label=
  label_drawing=on
  IFS=$'\n'
  for app in ${apps}; do
    icon=$("${CONFIG_DIR}/plugins/app_icon.sh" "${app}")
    label="${label}${icon} "
  done

fi

sketchybar --set "${NAME}" \
  drawing="${drawing}" \
  label="${label}" \
  label.drawing="${label_drawing}" \
  background.color="${background_color}"

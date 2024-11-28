#!/usr/bin/env bash

label=
drawing=off
background_drawing=off

# mapfile -t apps < <(aerospace list-windows --workspace "$1" --format '%{app-name}')
apps=$(aerospace list-windows --workspace "$1" --format '%{app-name}' | sort -u)
if [ -n "${apps}" ]; then

  echo "$1 --- ${apps}" >> ~/log.txt

  drawing=on

  focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
  if [ "$1" = "${focused}" ]; then
    background_drawing=on
  fi

  label=
  IFS=$'\n'
  for app in ${apps}; do
    icon=$("${CONFIG_DIR}/plugins/app_icon.sh" "${app}")
    echo "$1 ${icon} ${app}" >> ~/log.txt
    label="${label}${icon} "
  done

fi

sketchybar --set "${NAME}" \
  drawing="${drawing}" \
  background.drawing="${background_drawing}" \
  label="${label}"

exit

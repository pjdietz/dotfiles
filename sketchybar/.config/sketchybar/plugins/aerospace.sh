#!/usr/bin/env bash

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

WINDOWS=$(aerospace list-windows --workspace "$1")

if [ -n "${WINDOWS}" ]; then
  sketchybar --set "${NAME}" drawing=on
else
  sketchybar --set "${NAME}" drawing=off
fi

if [ "$1" = "${FOCUSED_WORKSPACE}" ]; then
    sketchybar --set "${NAME}" background.drawing=on
else
    sketchybar --set "${NAME}" background.drawing=off
fi

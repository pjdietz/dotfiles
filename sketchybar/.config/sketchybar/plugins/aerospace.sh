#!/usr/bin/env bash

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

echo "1: $1, FW: $FOCUSED_WORKSPACE, N: $NAME" >> ~/log.txt

if [ "$1" = "${FOCUSED_WORKSPACE}" ]; then
    sketchybar --set "${NAME}" background.drawing=on
else
    sketchybar --set "${NAME}" background.drawing=off
fi

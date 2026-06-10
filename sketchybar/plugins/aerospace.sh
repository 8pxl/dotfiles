#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0x00393552 label.shadow.drawing=off icon.shadow.drawing=off background.border_width=3 background.border_color=0xFFeb6f92 background.corner_radius=8
else
  sketchybar --set $NAME background.color=0x00FFFFFF label.shadow.drawing=off icon.shadow.drawing=off background.border_width=0
fi

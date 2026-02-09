#!/bin/bash

FRONT_APP=(
    label.font="$FONT:Bold:12.0"
    label.color=$FOAM
    # icon.font="$FONT:Bold:16.0"
    icon.font="sketchybar-app-font:Regular:16.0"
    icon.color=$TEXT
    background.color=$TRANSPARENT
    script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left --set front_app "${FRONT_APP[@]}" --subscribe front_app front_app_switched
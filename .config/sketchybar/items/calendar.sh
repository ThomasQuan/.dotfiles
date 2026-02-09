#!/bin/bash

CALENDAR=(
    icon.padding_left=12
    label.padding_right=12
    label.font="$FONT:Bold:12.0"
    label.color=$LOVE
    icon.font="$FONT:Bold:16.0"
    icon.color=$LOVE
    background.height=26
    background.color=$OVERLAY
    background.corner_radius=10
    script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right --set calendar "${CALENDAR[@]}" update_freq=15
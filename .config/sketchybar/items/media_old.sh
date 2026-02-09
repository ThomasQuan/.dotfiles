#!/bin/bash

MEDIA=(
    icon.padding_left=12
    label.padding_right=12
    label.font="$FONT:Bold:12.0"
    label.color=$LOVE
    label.max_chars=16
    scroll_texts=true
    icon.font="$FONT:Bold:16.0"
    icon.padding_left=10
    icon.color=$LOVE
    background.height=26
    background.color=$OVERLAY
    background.corner_radius=10
    script="$PLUGIN_DIR/media.sh"
    updates=on
)

sketchybar --add item media right --set media "${MEDIA[@]}" --subscribe media media_change

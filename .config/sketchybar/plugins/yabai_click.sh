#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

yabai_mode=$(yabai -m query --spaces --space | jq -r .type)

case "$yabai_mode" in
    bsp)
    yabai -m space --layout stack && sketchybar -m --set yabai_mode label="$YABAI_STACK" label.color="$GOLD"
    ;;
    stack)
    yabai -m space --layout float && sketchybar -m --set yabai_mode label="$YABAI_FLOAT" label.color="$IRIS"
    ;;
    float)
    yabai -m space --layout bsp && sketchybar -m --set yabai_mode label="$YABAI_BSP" label.color="$LOVE"
    ;;
esac

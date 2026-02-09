#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

yabai_mode=$(yabai -m query --spaces --space | jq -r .type)

case "$yabai_mode" in
    bsp)
        icon="$YABAI_BSP"
        color=$LOVE
        ;;
    stack)
        icon="$YABAI_STACK"
        color=$GOLD
        ;;
    float)
        icon="$YABAI_FLOAT"
        color=$IRIS
        ;;
    *)
        icon="?"
        color=$TEXT 
        ;;
esac

sketchybar --set $NAME label="$icon" label.color="$color"

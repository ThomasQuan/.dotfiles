#!/bin/bash

# CPU Component
CPU=(
    icon=$SYSINFO_CPU
    icon.font="$FONT:Bold:16.0"
    icon.color=$ROSE
    icon.padding_left=4
    icon.padding_right=4
    label.font="$FONT:Bold:12.0"
    label.color=$ROSE
    label.padding_left=4
    label.padding_right=12
    update_freq=2
    script="$PLUGIN_DIR/cpu.sh"
)

# Memory Component
MEMORY=(
    icon=$SYSINFO_MEMORY
    icon.font="$FONT:Bold:16.0"
    icon.color=$GOLD
    icon.padding_left=4
    icon.padding_right=4
    label.font="$FONT:Bold:12.0"
    label.color=$GOLD
    label.padding_left=4
    label.padding_right=4
    update_freq=2
    script="$PLUGIN_DIR/memory.sh"
)

# 添加左侧空白占位符
sketchybar --add item spacer_left right \
           --set spacer_left width=4 \
                             drawing=on

sketchybar --add item cpu right \
           --set cpu "${CPU[@]}" \
           \
           --add item memory right \
           --set memory "${MEMORY[@]}" \
           \
           --add bracket sysinfo cpu memory \
           --set sysinfo background.color=$OVERLAY \
                        background.height=26 \
                        background.corner_radius=10 \
                        background.padding_left=4 \
                        background.padding_right=4

# 添加右侧空白占位符
sketchybar --add item spacer_right right \
           --set spacer_right width=4 \
                              drawing=on

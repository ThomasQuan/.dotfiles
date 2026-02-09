#!/bin/bash

POPUP_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"
SOUND=(
    icon.padding_left=12
    label.padding_right=12
    label.font="$FONT:Bold:12.0"
    label.color=$LOVE
    icon.font="$FONT:Bold:16.0"
    icon.color=$LOVE
    background.height=26
    background.color=$OVERLAY
    background.corner_radius=10
    script="$PLUGIN_DIR/sound.sh"
    click_script="$POPUP_SCRIPT"
    popup.horizontal=on
    popup.align=center
    popup.height=30
    popup.y_offset=10
    popup.background.color=$OVERLAY
    popup.background.border_width=2
    popup.background.border_color=$LOVE
    popup.background.corner_radius=10
)

SOUND_SLIDER=(
    script="$PLUGIN_DIR/sound.sh"
    label.drawing=off
    icon.drawing=off
    padding_left=12
    padding_right=12
    slider.highlight_color=$LOVE
    slider.background.height=6
    slider.background.corner_radius=1
    slider.background.color=$MUTED
    slider.knob=􀀁
    slider.knob.drawing=off
    slider.width=120
)
sketchybar --add item sound right --set sound "${SOUND[@]}" --subscribe sound volume_change --add slider sound.slider popup.sound --set sound.slider "${SOUND_SLIDER[@]}" --subscribe sound.slider mouse.clicked mouse.entered mouse.exited
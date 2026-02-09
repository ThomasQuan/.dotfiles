#!/bin/bash

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

APPLE_LOGO=(
    icon="$APPLE"
    icon.color=$LOVE
    icon.padding_left=4
    icon.padding_right=20
    label.drawing=off
    background.color=$TRANSPARENT
    click_script="$POPUP_CLICK_SCRIPT"
    popup.background.color=$OVERLAY
    popup.background.border_width=2
    popup.background.border_color=$LOVE
    popup.background.corner_radius=10
    popup.y_offset=10
)

APPLE_PREFS=(
    icon="$PREFERENCES"
    label="Preferences"
    icon.color=$LOVE
    label.color=$FOAM
    click_script="open -a 'System Preferences'; $POPUP_OFF"
)

APPLE_ACTIVITY=(
    icon="$ACTIVITY"
    label="Activity"
    icon.color=$LOVE
    label.color=$FOAM
    click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

APPLE_LOCK=(
    icon="$LOCK"
    label="Lock Screen"
    icon.color=$LOVE
    label.color=$FOAM
    click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${APPLE_LOGO[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${APPLE_PREFS[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${APPLE_ACTIVITY[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${APPLE_LOCK[@]}"

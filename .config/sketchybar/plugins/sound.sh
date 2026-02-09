#!/bin/bash

source "$CONFIG_DIR/icons.sh"

volume_change() {
    VOLUME=$INFO
    MUTED=$(osascript -e "output muted of (get volume settings)")

    if [ "$MUTED" = "true" ]; then
        ICON="$SOUND_MUTED"
    else
        case $VOLUME in
            100) ICON="$SOUND_FULL" ;;
            9[0-9]) ICON="$SOUND_90" ;;
            8[0-9]) ICON="$SOUND_80" ;;
            7[0-9]) ICON="$SOUND_70" ;;
            6[0-9]) ICON="$SOUND_60" ;;
            5[0-9]) ICON="$SOUND_50" ;;
            4[0-9]) ICON="$SOUND_40" ;;
            3[0-9]) ICON="$SOUND_30" ;;
            2[0-9]) ICON="$SOUND_20" ;;
            1[0-9]) ICON="$SOUND_10" ;;
            [0-9]) ICON="$SOUND_LOW" ;;
            *) ICON="$SOUND_DEFAULT" ;;
        esac
    fi

    sketchybar --set sound icon="$ICON" label="$VOLUME%"
    sketchybar --set sound.slider slider.percentage=$INFO
}

mouse_clicked() {
    osascript -e "set volume output volume $PERCENTAGE"
}

mouse_entered() {
    sketchybar --set sound.slider slider.knob.drawing=on
}

mouse_exited() {
    sketchybar --set sound.slider slider.knob.drawing=off
}

case "$SENDER" in
    "volume_change") volume_change ;;
    "mouse.clicked") mouse_clicked ;;
    "mouse.entered") mouse_entered ;;
    "mouse.exited") mouse_exited ;;
esac

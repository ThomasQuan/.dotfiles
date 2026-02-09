#!/bin/bash

source "$CONFIG_DIR/icons.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
    sketchybar --set $NAME icon="$BATTERY_CHARGING" label="AC Power"
    exit 0
fi

case ${PERCENTAGE} in
    9[0-9]|100) ICON="$BATTERY_FULL" ;;
    [6-8][0-9]) ICON="$BATTERY_HIGH" ;;
    [3-5][0-9]) ICON="$BATTERY_MEDIUM" ;;
    [1-2][0-9]) ICON="$BATTERY_LOW" ;;
    *) ICON="$BATTERY_CRITICAL"
esac

if [[ $CHARGING != "" ]]; then
    ICON="$BATTERY_CHARGING"
fi

sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"
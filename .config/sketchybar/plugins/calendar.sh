#!/bin/bash

source "$CONFIG_DIR/icons.sh"

sketchybar --set $NAME icon="$CALENDAR" label="$(LC_TIME=en_US.UTF-8 date '+%a %d. %b')"
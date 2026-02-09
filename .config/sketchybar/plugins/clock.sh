#!/bin/bash

source "$CONFIG_DIR/icons.sh"

LABEL=$(date '+%H:%M')
sketchybar --set $NAME icon="$CLOCK" label="$LABEL"
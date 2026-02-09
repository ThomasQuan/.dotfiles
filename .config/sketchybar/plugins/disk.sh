#!/bin/bash

PERCENTAGE=$(df -k / | awk 'NR==2{printf "%d", int(($2 - $4) / $2 * 100)}')

sketchybar --set $NAME label="${PERCENTAGE}%"

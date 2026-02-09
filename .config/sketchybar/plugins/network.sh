#!/bin/bash

source "$CONFIG_DIR/icons.sh"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
    ICON="$NETWORK_VPN"
    LABEL="$IP_ADDRESS"
elif [[ $IP_ADDRESS != "" ]]; then
    ICON="$NETWORK_STRONG"
    LABEL="$IP_ADDRESS"
else
    ICON="$NETWORK_OFFLINE"
    LABEL="Offline"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
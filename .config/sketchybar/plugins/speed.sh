#!/bin/bash

CACHE_FILE="/tmp/sketchybar_speed_cache"

# Find first active en* interface
find_active_interface() {
    for i in 0 1 2 3; do
        if ifconfig en${i} 2>/dev/null | grep -q "status: active"; then
            echo "en${i}"
            return
        fi
    done
    echo "en0"
}

# Get active network interface (prefer en*, exclude utun* VPN interfaces)
get_interface() {
    local iface=$(route -n get default 2>/dev/null | grep 'interface:' | awk '{print $2}')
    if [[ "$iface" == utun* ]] || [[ -z "$iface" ]]; then
        # VPN active or no default route, find first active en* interface
        find_active_interface
    else
        echo "$iface"
    fi
}

# Format bytes to human readable
format_speed() {
    local bytes=$1
    if [[ $bytes -ge 1048576 ]]; then
        printf "%.1f MB/s" $(echo "scale=1; $bytes / 1048576" | bc)
    elif [[ $bytes -ge 1024 ]]; then
        printf "%.0f KB/s" $(echo "scale=0; $bytes / 1024" | bc)
    else
        printf "%d B/s" $bytes
    fi
}

INTERFACE=$(get_interface)

# Get current bytes from netstat -ib
# Format: Name Mtu Network Address Ipkts Ierrs Ibytes Opkts Oerrs Obytes Coll
STATS=$(netstat -ib | grep -E "^${INTERFACE}\s" | grep -v 'Link#' | head -1)

if [[ -z "$STATS" ]]; then
    sketchybar --set speed_down label="--" \
               --set speed_up label="--"
    exit 0
fi

CURRENT_DOWN=$(echo "$STATS" | awk '{print $7}')
CURRENT_UP=$(echo "$STATS" | awk '{print $10}')
CURRENT_TIME=$(date +%s)

# Read previous values from cache
if [[ -f "$CACHE_FILE" ]]; then
    read PREV_DOWN PREV_UP PREV_TIME < "$CACHE_FILE"

    # Calculate time difference
    TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

    if [[ $TIME_DIFF -gt 0 ]]; then
        # Calculate bytes per second
        DOWN_SPEED=$(( (CURRENT_DOWN - PREV_DOWN) / TIME_DIFF ))
        UP_SPEED=$(( (CURRENT_UP - PREV_UP) / TIME_DIFF ))

        # Handle negative values (interface reset or overflow)
        [[ $DOWN_SPEED -lt 0 ]] && DOWN_SPEED=0
        [[ $UP_SPEED -lt 0 ]] && UP_SPEED=0

        DOWN_LABEL=$(format_speed $DOWN_SPEED)
        UP_LABEL=$(format_speed $UP_SPEED)
    else
        DOWN_LABEL="0 B/s"
        UP_LABEL="0 B/s"
    fi
else
    DOWN_LABEL="0 B/s"
    UP_LABEL="0 B/s"
fi

# Save current values to cache
echo "$CURRENT_DOWN $CURRENT_UP $CURRENT_TIME" > "$CACHE_FILE"

# Update sketchybar
sketchybar --set speed_down label="$DOWN_LABEL" \
           --set speed_up label="$UP_LABEL"

#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

next() {
    osascript -e 'tell application "Spotify" to play next track'
}

back() {
    osascript -e 'tell application "Spotify" to play previous track'
}

play() {
    osascript -e 'tell application "Spotify" to playpause'
}

repeat() {
    REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
    if [ "$REPEAT" = "false" ]; then
        sketchybar --set media.repeat icon.color=$LOVE
        osascript -e 'tell application "Spotify" to set repeating to true'
    else
        sketchybar --set media.repeat icon.color=$TEXT
        osascript -e 'tell application "Spotify" to set repeating to false'
    fi
}

update() {
    PLAYING=1
    if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
        PLAYING=0
        TITLE=$(echo "$INFO" | jq -r .Name | sed 's/\(.\{16\}\).*/\1.../')
        ARTIST=$(echo "$INFO" | jq -r .Artist | sed 's/\(.\{16\}\).*/\1.../')
        ALBUM=$(echo "$INFO" | jq -r .Album | sed 's/\(.\{16\}\).*/\1.../')
        COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
        REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')

        # 下载专辑封面
        if [ -n "$COVER" ]; then
            curl -s --max-time 10 "$COVER" -o /tmp/spotify_cover.jpg 2>/dev/null
        fi
    fi

    args=()
    if [ $PLAYING -eq 0 ]; then
        if [ "$ARTIST" == "" ]; then
            args+=(--set media label="$TITLE - $ALBUM" drawing=on)
        else
            args+=(--set media label="$TITLE - $ARTIST" drawing=on)
        fi
        args+=(--set media.play icon=$MEDIA_PAUSE)
        args+=(--set media.cover background.image="/tmp/spotify_cover.jpg")
        args+=(--set media.title label="$TITLE")
        args+=(--set media.artist label="$ARTIST")
        args+=(--set media.album label="$ALBUM")
        if [ "$REPEAT" = "true" ]; then
            args+=(--set media.repeat icon.color=$LOVE)
        else
            args+=(--set media.repeat icon.color=$TEXT)
        fi
    else
        args+=(--set media drawing=off)
        args+=(--set media popup.drawing=off)
        args+=(--set media.play icon=$MEDIA_PLAY)
    fi
    sketchybar "${args[@]}"
}

scroll() {
    DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track')
    DURATION=$((DURATION_MS/1000))

    FLOAT="$(osascript -e 'tell application "Spotify" to get player position')"
    TIME=${FLOAT%.*}

    sketchybar --animate linear 10 \
               --set media.state slider.percentage="$((TIME*100/DURATION))" \
                                 icon="$(date -r $TIME +'%M:%S')" \
                                 label="$(date -r $DURATION +'%M:%S')"
}

scrubbing() {
    DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track')
    DURATION=$((DURATION_MS/1000))
    TARGET=$((DURATION*PERCENTAGE/100))
    osascript -e "tell application \"Spotify\" to set player position to $TARGET"
    sketchybar --set media.state slider.percentage=$PERCENTAGE
}

mouse_clicked() {
    case "$NAME" in
        "media.next") next ;;
        "media.back") back ;;
        "media.play") play ;;
        "media.repeat") repeat ;;
        "media.state") scrubbing ;;
        *) exit ;;
    esac
}

case "$SENDER" in
    "mouse.clicked") mouse_clicked ;;
    "routine")
        case "$NAME" in
            "media.state") scroll ;;
            *) update ;;
        esac
        ;;
    "forced") exit 0 ;;
    *) update ;;
esac

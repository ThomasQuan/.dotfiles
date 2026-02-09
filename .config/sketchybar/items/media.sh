#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
POPUP_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

MEDIA=(
    icon=$MEDIA
    icon.padding_left=12
    label.padding_right=12
    label.font="$FONT:Bold:12.0"
    label.color=$LOVE
    label.max_chars=20
    scroll_texts=true
    icon.font="$FONT:Bold:16.0"
    icon.color=$LOVE
    background.height=26
    background.color=$OVERLAY
    background.corner_radius=10
    popup.horizontal=on
    popup.align=center
    popup.height=170
    popup.y_offset=10
    popup.background.color=$OVERLAY
    popup.background.border_width=2
    popup.background.border_color=$LOVE
    popup.background.corner_radius=10
    script="$PLUGIN_DIR/media.sh"
    click_script="$POPUP_SCRIPT"
    drawing=off
)

MEDIA_COVER=(
    script="$PLUGIN_DIR/media.sh"
    click_script="open -a 'Spotify'; sketchybar --set media popup.drawing=off"
    label.drawing=off
    icon.drawing=off
    padding_left=12
    padding_right=10
    background.image.scale=0.2
    background.image.drawing=on
    background.drawing=on
)

MEDIA_TITLE=(
    icon.drawing=off
    label.font="$FONT:Bold:10.0"
    label.color=$LOVE
    label.max_chars=15
    padding_left=0
    padding_right=0
    width=0
    y_offset=55
)

MEDIA_ARTIST=(
    icon.drawing=off
    label.font="$FONT:Regular:12.0"
    label.color=$FOAM
    padding_left=0
    padding_right=0
    width=0
    y_offset=30
)

MEDIA_ALBUM=(
    icon.drawing=off
    label.font="$FONT:Regular:10.0"
    label.color=$FOAM
    label.max_chars=15
    padding_left=0
    padding_right=0
    width=0
    y_offset=15
)

MEDIA_STATE=(
    icon.drawing=on
    icon.font="$FONT:Italic:10.0"
    icon.color=$TEXT
    icon.width=35
    icon="00:00"
    label.drawing=on
    label.font="$FONT:Italic:10.0"
    label.color=$TEXT
    label.width=35
    label="00:00"
    padding_left=0
    padding_right=0
    width=0
    y_offset=-15
    slider.background.height=6
    slider.background.corner_radius=1
    slider.background.color=$MUTED
    slider.highlight_color=$LOVE
    slider.percentage=40
    slider.width=60
    script="$PLUGIN_DIR/media.sh"
    update_freq=1
    updates=when_shown
)

MEDIA_BACK=(
    icon=$MEDIA_BACK
    icon.font="$FONT:Bold:14.0"
    icon.color=$TEXT
    icon.padding_left=8
    icon.padding_right=8
    label.drawing=off
    script="$PLUGIN_DIR/media.sh"
    y_offset=-55
)

MEDIA_PLAY=(
    icon=$MEDIA_PLAY
    background.height=40
    background.corner_radius=20
    width=40
    align=center
    background.color=$OVERLAY
    background.border_color=$LOVE
    background.border_width=2
    background.drawing=on
    icon.font="$FONT:Bold:18.0"
    icon.color=$LOVE
    icon.padding_left=4
    icon.padding_right=4
    updates=on
    label.drawing=off
    script="$PLUGIN_DIR/media.sh"
    y_offset=-55
)

MEDIA_NEXT=(
    icon=$MEDIA_NEXT
    icon.font="$FONT:Bold:14.0"
    icon.color=$TEXT
    icon.padding_left=8
    icon.padding_right=8
    label.drawing=off
    script="$PLUGIN_DIR/media.sh"
    y_offset=-55
)

MEDIA_REPEAT=(
    icon=$MEDIA_REPEAT
    icon.font="$FONT:Bold:14.0"
    icon.color=$TEXT
    icon.padding_left=8
    icon.padding_right=8
    label.drawing=off
    script="$PLUGIN_DIR/media.sh"
    y_offset=-55
)

MEDIA_CONTROLS=(
    background.color=$LOVE
    background.corner_radius=10
    background.drawing=on
    y_offset=-55
)

sketchybar --add event spotify_change $SPOTIFY_EVENT \
           \
           --add item media right \
           --set media "${MEDIA[@]}" \
           --subscribe media spotify_change \
           \
           --add item media.cover popup.media \
           --set media.cover "${MEDIA_COVER[@]}" \
           --subscribe media.cover mouse.clicked \
           \
           --add item media.title popup.media \
           --set media.title "${MEDIA_TITLE[@]}" \
           \
           --add item media.artist popup.media \
           --set media.artist "${MEDIA_ARTIST[@]}" \
           \
           --add item media.album popup.media \
           --set media.album "${MEDIA_ALBUM[@]}" \
           \
           --add slider media.state popup.media \
           --set media.state "${MEDIA_STATE[@]}" \
           --subscribe media.state mouse.clicked \
           \
           --add item media.back popup.media \
           --set media.back "${MEDIA_BACK[@]}" \
           --subscribe media.back mouse.clicked \
           \
           --add item media.play popup.media \
           --set media.play "${MEDIA_PLAY[@]}" \
           --subscribe media.play mouse.clicked spotify_change \
           \
           --add item media.next popup.media \
           --set media.next "${MEDIA_NEXT[@]}" \
           --subscribe media.next mouse.clicked \
           \
           --add item media.repeat popup.media \
           --set media.repeat "${MEDIA_REPEAT[@]}" \
           --subscribe media.repeat mouse.clicked \
           \
           --add bracket media.controls media.back media.play media.next media.repeat \
           --set media.controls "${MEDIA_CONTROLS[@]}"

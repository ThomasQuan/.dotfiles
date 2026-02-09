#!/bin/bash

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
    # 获取媒体信息
    FULL_TEXT="$(echo "$INFO" | jq -r '.app + ": " + .title + " - " + .artist')"
    # 设置最大显示字符数
    MAX_LENGTH=64
    # 如果内容超过最大长度,进行截断
    if [ ${#FULL_TEXT} -gt $MAX_LENGTH ]; then
        MEDIA="${FULL_TEXT:0:MAX_LENGTH}..."  # 截取并添加省略号
    else
        MEDIA="$FULL_TEXT"  # 不超长则显示完整内容
    fi

    sketchybar --set $NAME label="$MEDIA" drawing=on
else
    sketchybar --set $NAME drawing=off
fi

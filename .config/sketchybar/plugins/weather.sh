#!/bin/bash

source "$CONFIG_DIR/icons.sh"

# 城市设置
CITY="Toronto"

# set -x # 调试模式，显示执行的命令

# 设置重试次数和延迟时间
MAX_RETRIES=3
DELAY=5 # 秒
DEFAULT_TEMPERATURE="N/A"
DEFAULT_ICON="$WEATHER_DEFAULT" # 默认未知情况图标

# 初始化温度和图标为默认值
TEMPERATURE=$DEFAULT_TEMPERATURE
CUSTOM_ICON=$DEFAULT_ICON

for ((i = 1; i <= MAX_RETRIES; i++)); do
    # 获取 JSON 格式的天气数据
    WEATHER_JSON=$(curl -s "wttr.in/${CITY}?format=j1")
    if [[ -n "$WEATHER_JSON" && "$(echo $WEATHER_JSON | jq -r '.current_condition[0].temp_C')" != "null" ]]; then
        # 从 JSON 中提取温度和天气描述
        TEMPERATURE=$(echo $WEATHER_JSON | jq -r '.current_condition[0].temp_C')
        DESCRIPTION=$(echo $WEATHER_JSON | jq -r '.current_condition[0].weatherDesc[0].value')
        # echo $TEMPERATURE
        # echo $DESCRIPTION
        break
    else
        echo "Retry #$i: Failed to fetch weather data." >> "/tmp/weather.log"
        sleep $DELAY
    fi
done

# 如果超过最大重试次数仍失败，使用默认温度和图标
if [[ -z "$WEATHER_JSON" || "$TEMPERATURE" == "null" ]]; then
    TEMPERATURE=$DEFAULT_TEMPERATURE
    CUSTOM_ICON=$DEFAULT_ICON
else
    # 根据天气描述设置自定义图标
    case $DESCRIPTION in
    *[Ss]un*|*[Cc]lear*) CUSTOM_ICON="$WEATHER_SUNNY" ;;                           # 晴天
    *[Cc]loud*|*[Oo]vercast*|*[Pp]artly*) CUSTOM_ICON="$WEATHER_CLOUDY" ;;         # 部分多云
    *[Rr]ain*|*[Ss]hower*) CUSTOM_ICON="$WEATHER_RAINY" ;;                         # 雨
    *[Tt]hunder*|*[Ss]torm*) CUSTOM_ICON="$WEATHER_STORMY" ;;                      # 雷雨
    *[Ss]now*|*[Bb]lizzard*) CUSTOM_ICON="$WEATHER_SNOWY" ;;                       # 雪
    *[Mm]ist*) CUSTOM_ICON="$WEATHER_MISTY" ;;                                     # 雾
    *[Hh]aze*) CUSTOM_ICON="$WEATHER_HAZE" ;;                                      # 霾
    *) CUSTOM_ICON="$WEATHER_DEBUG" ;;                                             # 默认图标：未知情况
    esac
fi

# 设置 SketchyBar 显示
sketchybar --set $NAME icon="$CUSTOM_ICON" label="${TEMPERATURE}°C"

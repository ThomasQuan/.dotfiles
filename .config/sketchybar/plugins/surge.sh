#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

API_BASE="http://127.0.0.1:6171"
API_KEY="smallsun"

# 获取当前模式
get_mode() {
    local response=$(curl -s -X GET "$API_BASE/v1/outbound" -H "X-Key: $API_KEY" 2>/dev/null)
    echo "$response" | grep -o '"mode":"[^"]*"' | cut -d'"' -f4
}

# 设置模式
set_mode() {
    local mode=$1
    curl -s -X POST "$API_BASE/v1/outbound" \
        -H "X-Key: $API_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"mode\":\"$mode\"}" >/dev/null 2>&1
}

# 模式转图标
mode_to_icon() {
    case "$1" in
        "rule")   echo "$SURGE_RULE" ;;
        "proxy")  echo "$SURGE_GLOBAL" ;;
        "direct") echo "$SURGE_DIRECT" ;;
        *)        echo "?" ;;
    esac
}

# 处理点击事件
if [[ "$SENDER" == "mouse.clicked" ]]; then
    sketchybar --set surge popup.drawing=toggle
elif [[ "$1" == "set_direct" ]]; then
    set_mode "direct"
    sketchybar --set surge icon="$SURGE_DIRECT" label="D" icon.color=$FOAM label.color=$FOAM popup.drawing=off
elif [[ "$1" == "set_proxy" ]]; then
    set_mode "proxy"
    sketchybar --set surge icon="$SURGE_GLOBAL" label="G" icon.color=$GOLD label.color=$GOLD popup.drawing=off
elif [[ "$1" == "set_rule" ]]; then
    set_mode "rule"
    sketchybar --set surge icon="$SURGE_RULE" label="R" icon.color=$PINE label.color=$PINE popup.drawing=off
else
    # 定时更新状态
    MODE=$(get_mode)
    case "$MODE" in
        "rule")
            sketchybar --set surge icon="$SURGE_RULE" label="R" icon.color=$PINE label.color=$PINE
            ;;
        "proxy")
            sketchybar --set surge icon="$SURGE_GLOBAL" label="G" icon.color=$GOLD label.color=$GOLD
            ;;
        "direct")
            sketchybar --set surge icon="$SURGE_DIRECT" label="D" icon.color=$FOAM label.color=$FOAM
            ;;
        *)
            sketchybar --set surge icon="?" label="?" icon.color=$LOVE label.color=$LOVE
            ;;
    esac
fi

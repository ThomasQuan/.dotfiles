#!/bin/bash

DEFAULT=(
    label.font="$FONT:Bold:12.0"
    label.padding_left=0
    label.padding_right=0
    label.color=$LOVE
    icon.font="$FONT:Bold:12.0"
    icon.padding_left=0
    icon.padding_right=0
    icon.color=$LOVE
    background.height=26
    background.color=$OVERLAY
    background.padding_left=0
    background.padding_right=0
    background.corner_radius=10
)

sketchybar --add alias "iStat Menus Menubar,com.bjango.istatmenus.cpu" right --rename "iStat Menus Menubar,com.bjango.istatmenus.cpu" cpu_alias --set cpu_alias "${DEFAULT[@]}" alias.color="$LOVE"
sketchybar --add alias "iStat Menus Menubar,com.bjango.istatmenus.memory" right --rename "iStat Menus Menubar,com.bjango.istatmenus.memory" mem_alias --set mem_alias "${DEFAULT[@]}" alias.color="$LOVE"
sketchybar --add alias "iStat Menus Menubar,com.bjango.istatmenus.disks" right --rename "iStat Menus Menubar,com.bjango.istatmenus.disks" disks_alias --set disks_alias "${DEFAULT[@]}" alias.color="$LOVE"
sketchybar --add alias "iStat Menus Menubar,com.bjango.istatmenus.network" right --rename "iStat Menus Menubar,com.bjango.istatmenus.network" net_alias --set net_alias "${DEFAULT[@]}" alias.color="$LOVE"
# sketchybar --add alias "iStat Menus Menubar,com.bjango.istatmenus.weather" right --rename "iStat Menus Menubar,com.bjango.istatmenus.weather" weather_alias --set weather_alias "${DEFAULT[@]}" alias.color="$LOVE"

sketchybar --add alias "Surge,Item-0" right --rename "Surge,Item-0" vpn_alias --set vpn_alias "${DEFAULT[@]}" alias.color="$LOVE"
sketchybar --add alias "RunCat,Item-0" right --rename "RunCat,Item-0" cat_alias --set cat_alias "${DEFAULT[@]}" alias.color="$LOVE"

sketchybar --add bracket istat_bracket cpu_alias mem_alias disks_alias net_alias vpn_alias cat_alias --set istat_bracket "${DEFAULT[@]}"
#!/bin/env bash

# Listen for Hyprland events
#
POSITION=auto
for MONITOR in $(hyprctl monitors -j | jq -r '.[].name') ; do
    echo $MONITOR
    case $MONITOR in
        eDP-1)
            hyprctl -q keyword monitor "$MONITOR",preferred,"$POSITION",1.0
            POSITION=auto-left
            ;;
        HDMI*)
            WIDTH=$(hyprctl monitors -j | jq '.[] | select (.name=="HDMI-A-1") .width')
            if [ $WIDTH -gt 3000 ]; then
                SCALE=1.2
            else
                SCALE=0.8
            fi
            hyprctl -q keyword monitor "$MONITOR",preferred,"$POSITION",$SCALE
            ;;
    esac
done

#!/bin/env bash

LOG_FILE=~/.config/hypr/events.log

# Listen for Hyprland events
#
get_params() {
    echo $1 | sed -e 's/^.*>>//'
}

handle_event() {
  case $1 in
      monitoradded\>\>*)
          MONITOR=$(get_params "$1")
          if [[ ! $MONITOR =~ HEADLESS ]] ; then
              # echo adding monitor $MONITOR
              WIDTH=$(hyprctl monitors -j | jq '.[] | select (.name=="HDMI-A-1") .width')
              if [ $WIDTH -gt 3000 ]; then
                  SCALE=1.2
              else
                  SCALE=0.8
              fi
              # echo hyprctl keyword monitor "$MONITOR",preferred,auto-left,$SCALE
              hyprctl keyword monitor "$MONITOR",preferred,auto-left,$SCALE
          fi
          ;;
      monitoraddedv2\>\>*)
          MONITOR=$(get_params "$1")
          # echo adding monitor \(v2\) $MONITOR
          ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | \
    while read -r line; do handle_event "$line" ; done


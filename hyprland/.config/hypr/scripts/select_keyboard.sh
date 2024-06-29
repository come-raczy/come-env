#!/bin/env bash

MOSART="mosart-semi.-2.4g-input-device"
BLUETOOTH="bluetooth-5.1-keyboard"

for keyboard in $(hyprctl devices -j | jq -r ".keyboards[].name") ; do
    if [ $keyboard == "$BLUETOOTH" ] ; then
        echo $keyboard
        exit
    fi
    if [ $keyboard == "$MOSART" ] ; then
        echo $keyboard
        exit
    fi
done


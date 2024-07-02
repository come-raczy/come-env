#!/bin/env bash

MOSART="mosart-semi.-2.4g-input-device"
BLUETOOTH="bluetooth-5.1-keyboard"
LAPTOP="at-translated-set-2-keyboard"

# First check for the external keyboards

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

# If no external keyboard is found, use the laptop keyboard
echo $LAPTOP


#!/bin/env bash

WORKSPACES_FILE=$HOME/.config/hypr/workspaces.txt

case $1 in
    save)
        hyprctl monitors -j | jq '.[] | "\(.id)-\(.activeWorkspace.id)-\(.focused)"' -r > "$WORKSPACES_FILE"
        ;;
    restore)
        if [[ -f "$WORKSPACES_FILE" ]] ; then
            FOCUSED=0
            for l in  $(cat "$WORKSPACES_FILE") ; do
                a=(${l//-/ })
                #hyprctl dispatch moveworkspacetomonitor "${a[1]}" "${a[0]}"
                hyprctl dispatch focusmonitor "${a[0]}"
                hyprctl dispatch focusworkspaceoncurrentmonitor "${a[1]}"
                if [[ "${a[2]}" == "true" ]] ; then
                    FOCUSED="${a[0]}"
                fi
            done ;
            hyprctl dispatch focusmonitor "$FOCUSED"
        fi
        ;;
esac

#!/bin/bash

while true; do
    if ! pgrep -x hyprlock > /dev/null; then
        playerctl play
        break
    fi
    sleep 0.2
done

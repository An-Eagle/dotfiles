#!/bin/bash

# Get the current layout index using jq
current_idx=$(niri msg --json keyboard-layouts | jq '.current_idx')

# Toggle layout index: 0 -> 1, 1 -> 0
if [ "$current_idx" -eq 0 ]; then
    niri msg action switch-layout 1
else
    niri msg action switch-layout 0
fi

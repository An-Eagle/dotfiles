#!/bin/bash

default_source=$(pactl info | grep "Default Source" | awk '{print $3}')
mute=$(pactl get-source-mute "$default_source" | awk '{print $2}')
volume=$(pactl get-source-volume "$default_source" | grep -oP '\d+%' | head -1 | tr -d '%')

if [[ "$mute" == "yes" ]]; then
    icon=""
    class="muted"
else
    icon=" $volume%"
    class="active"
fi

text="<span class='mic-icon'>$icon</span> <span class='mic-volume'>$volume%</span>"

# Print compact JSON without newlines or indentation:
echo "{\"text\": \"$icon\", \"class\": \"$class\"}"

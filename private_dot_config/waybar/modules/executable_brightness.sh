#!/bin/bash

STEP=1  # percentage step for scroll events

# Handle scroll events
if [[ "$1" == "up" ]]; then
    brightnessctl set +${STEP}%
elif [[ "$1" == "down" ]]; then
    brightnessctl set ${STEP}%- 
fi

# Get current brightness
CURRENT=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$(( 100 * CURRENT / MAX ))

# Choose icon based on level
if   [ "$PERCENT" -ge 90 ]; then ICON=""
elif [ "$PERCENT" -ge 80 ]; then ICON=""
elif [ "$PERCENT" -ge 70 ]; then ICON=""
elif [ "$PERCENT" -ge 60 ]; then ICON=""
elif [ "$PERCENT" -ge 50 ]; then ICON=""
elif [ "$PERCENT" -ge 40 ]; then ICON=""
elif [ "$PERCENT" -ge 30 ]; then ICON=""
elif [ "$PERCENT" -ge 20 ]; then ICON=""
else                             ICON=""
fi

# Output JSON
echo "{\"text\": \"$ICON $PERCENT%\", \"class\": \"brightness\"}"

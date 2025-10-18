#!/bin/bash

# Get the ID of the first available paired + reachable device
DEVICE_ID=$(kdeconnect-cli -a --id-only | head -n 1)

if [ -z "$DEVICE_ID" ]; then
    echo '{"text":"🔌 No Device","tooltip":"No paired device found"}'
    exit 0
fi

# Check connection status
STATUS=$(kdeconnect-cli -d "$DEVICE_ID" | grep -q "reachable: true" && echo "🟢" || echo "🔴")

# Get battery level (if available)
BATTERY=$(kdeconnect-cli -d "$DEVICE_ID" --battery 2>/dev/null | grep -oP '\d+%' || echo "N/A")

# Get device name
DEVICE_NAME=$(kdeconnect-cli -d "$DEVICE_ID" | grep "name:" | cut -d ':' -f2- | xargs)

# Output for Waybar (JSON)
echo "{\"text\": \"$STATUS $BATTERY\", \"tooltip\": \"$DEVICE_NAME\"}"

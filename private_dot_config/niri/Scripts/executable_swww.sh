#!/bin/bash
echo "Script launched at $(date)" >> /tmp/niri-swww.log
GRAY_BG="$HOME/Pictures/wallpapers/graybackground.jpeg"
FINAL_BG="$HOME/Pictures/wallpapers/background.jpeg"
sleep 1

swww-daemon & swww img "$GRAY_BG" --transition-type none

# Wait until the log line appears
sleep 1
# Transition to actual wallpaper with a grow effect from top center
swww img "$FINAL_BG" \
  --transition-type grow \
  --transition-duration 4 \
  --transition-fps 60 \
  --transition-pos 0.5,1.0

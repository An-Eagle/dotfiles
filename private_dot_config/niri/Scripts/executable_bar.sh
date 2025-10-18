#!/bin/bash
distrobox enter waybar -- kdeconnectd & disown
sleep 1
distrobox enter waybar -- waybar

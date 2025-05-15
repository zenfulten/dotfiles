#!/bin/bash

WALL_DIR="$HOME/Images/Fav"
MONITOR="HDMI-A-1"
HYPCTL="/usr/bin/hyprctl"

# Get list of wallpapers
WALL=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort | rofi -dmenu -p "Choose Wallpaper")

# Set it
if [[ -f "$WALL" ]]; then
    $HYPCTL hyprpaper preload "$WALL"
    $HYPCTL hyprpaper wallpaper "$MONITOR,$WALL"
    notify-send -u low -i "$WALL"  "Rofi wallpaper applied..."
fi

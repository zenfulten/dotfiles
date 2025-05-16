#!/bin/bash

WALL_DIR="$HOME/Images/Fav"
MONITOR="HDMI-A-1"
HYPCTL="/usr/bin/hyprctl"

# Get list of wallpapers and extract just the filenames
WALL=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -printf '%f\n' | sort | rofi -dmenu -p "Choose Wallpaper")

# Set it
if [[ -n "$WALL" ]]; then
    FULL_PATH="$WALL_DIR/$WALL"
    if [[ -f "$FULL_PATH" ]]; then
        $HYPCTL hyprpaper preload "$FULL_PATH"
        $HYPCTL hyprpaper wallpaper "$MONITOR,$FULL_PATH"
        notify-send -u low -i "$FULL_PATH" "Rofi wallpaper applied..."
    fi
fi

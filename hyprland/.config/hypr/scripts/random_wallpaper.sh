#!/bin/bash

# Set monitor and wallpaper directory
MONITOR="HDMI-A-1"
WALL_DIR="/home/rio/Images/wallpapers"

# Get a random image
IMG=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

# Full path to hyprctl
HYPCTL="/usr/bin/hyprctl"

# Apply wallpaper if the image exists
if [[ -f "$IMG" ]]; then
    $HYPCTL hyprpaper preload "$IMG"
    $HYPCTL hyprpaper wallpaper "$MONITOR,$IMG"
fi

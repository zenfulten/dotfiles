#!/bin/bash
# Set monitor and wallpaper directory
# Note: For swww, the MONITOR variable might not be strictly necessary
# if swww-daemon is running and managing all outputs.
# However, it's kept here for consistency with the original script.
MONITOR="HDMI-A-1"
WALL_DIR="/home/rio/Images/wallpapers"

# Get a random image from the specified directory
IMG=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

# Full path to the swww command
# Ensure 'swww' is installed and its daemon is running (or will be started by the command).
# You might need to adjust this path if 'swww' is located elsewhere.
SWWW_CMD="/usr/bin/swww" # Assuming swww is in /usr/bin, adjust if necessary

# --- New: Check if swww is installed ---
if ! command -v swww &> /dev/null
then
    # If swww is not found, send a notification (requires 'notify-send' to be installed)
    notify-send "Wallpaper Script Error" "swww is not installed or not in your PATH. Please install it to use this script."
    exit 1 # Exit the script if swww is not found
fi

# Check if the randomly selected image file exists
if [[ -f "$IMG" ]]; then
    # Apply the wallpaper using swww with a transition animation.
    # Common transition types include: "fade", "grow", "wipe", "outer", "simple", "random"
    # --transition-step controls the number of steps in the animation.
    # --transition-fps controls the frames per second of the animation.
    # Adjust these values to your preference.
    "$SWWW_CMD" img "$IMG" \
        --transition-type "random" \
        --transition-step 100 \
        --transition-fps 60
else
    # If the image file is not found, send a notification
    notify-send "Wallpaper Script Error" "Image file not found at $IMG"
    echo "Error: Image file not found at $IMG"
fi


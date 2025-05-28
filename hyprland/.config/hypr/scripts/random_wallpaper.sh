#!/bin/bash

# Set monitor and wallpaper directory
# Note: For swww, the MONITOR variable might not be strictly necessary
# if swww-daemon is running and managing all outputs.
# However, it's kept here for consistency with the original script.
MONITOR="HDMI-A-1"
WALL_DIR="/home/rio/Images/wallpapers"

# Define the target directory for the current wallpaper copy
TARGET_WALLPAPER_DIR="$HOME/.config/images"
# Define the generic symlink path for other apps (like Rofi)
GENERIC_WALLPAPER_SYMLINK="$TARGET_WALLPAPER_DIR/current_wallpaper"

# Get a random image from the specified directory
# Broaden the image search to include more common formats
IMG=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | shuf -n 1)

# Full path to the swww command
# Ensure 'swww' is installed and its daemon is running (or will be started by the command).
# You might need to adjust this path if 'swww' is located elsewhere.
SWWW_CMD="/usr/bin/swww" # Assuming swww is in /usr/bin, adjust if necessary

# --- Check if swww is installed ---
if ! command -v swww &> /dev/null
then
    notify-send "Wallpaper Script Error" "swww is not installed or not in your PATH. Please install it to use this script."
    exit 1 # Exit the script if swww is not found
fi

# Check if WALL_DIR exists
if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Script Error" "Wallpaper directory '$WALL_DIR' does not exist."
    echo "Error: Wallpaper directory '$WALL_DIR' does not exist."
    exit 1
fi

# Check if the randomly selected image file exists
if [[ -f "$IMG" ]]; then
    # --- Image Copying and Symlinking Logic ---
    # Create the target directory if it doesn't exist
    mkdir -p "$TARGET_WALLPAPER_DIR"

    # Get the extension of the selected wallpaper
    EXTENSION="${IMG##*.}"
    TARGET_IMAGE="$TARGET_WALLPAPER_DIR/image.$EXTENSION"

    # Remove any existing 'image' files with various extensions in the target directory
    rm -f "$TARGET_WALLPAPER_DIR/image.jpg" \
          "$TARGET_WALLPAPER_DIR/image.jpeg" \
          "$TARGET_WALLPAPER_DIR/image.png" \
          "$TARGET_WALLPAPER_DIR/image.gif" \
          "$TARGET_WALLPAPER_DIR/image.bmp" \
          "$TARGET_WALLPAPER_DIR/image.tiff"

    # Copy the new wallpaper to the target location with its original extension
    cp "$IMG" "$TARGET_IMAGE"

    # Remove any old symlink or file named 'current_wallpaper'
    rm -f "$GENERIC_WALLPAPER_SYMLINK"
    # Create a new symlink pointing to the newly copied image
    ln -s "$TARGET_IMAGE" "$GENERIC_WALLPAPER_SYMLINK"
    # --- End Image Copying and Symlinking Logic ---

    # Apply the wallpaper using swww with a transition animation.
    "$SWWW_CMD" img "$IMG" \
        --transition-type "random" \
        --transition-step 100 \
        --transition-fps 60

    # Send a notification that the wallpaper has been applied
    notify-send -u low -i "$IMG" "Random wallpaper applied..."
else
    # If the image file is not found, send a notification
    notify-send "Wallpaper Script Error" "No suitable image found in '$WALL_DIR'."
    echo "Error: No suitable image found in '$WALL_DIR'."
    exit 1
fi

#!/bin/bash

# Set monitor (kept for consistency, though swww typically applies to all active outputs)
MONITOR="HDMI-A-1"

# Path to the swww command (adjust if necessary)
SWWW_CMD="/usr/bin/swww"

# Directory containing wallpapers (ensure WALL_DIR is set)
# Default to $HOME/Images/Fav if WALL_DIR is not already set
: "${WALL_DIR:=$HOME/Images/Fav}"

# Initialize ROFI_INPUT
ROFI_INPUT=""

# --- New: Check if swww is installed ---
if ! command -v swww &> /dev/null
then
    # If swww is not found, send a notification (requires 'notify-send' to be installed)
    notify-send "Wallpaper Script Error" "swww is not installed or not in your PATH. Please install it to use this script."
    exit 1 # Exit the script if swww is not found
fi

# Check if WALL_DIR exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Error: Wallpaper directory '$WALL_DIR' does not exist."
    notify-send "Wallpaper Script Error" "Wallpaper directory '$WALL_DIR' does not exist."
    exit 1
fi

# Find image files and prepare input for rofi
# Using -print0 and read -r -d $'\0' for robust handling of filenames with spaces/special characters
while IFS= read -r -d $'\0' file; do
    # Extract the filename using basename
    filename=$(basename "$file")
    # Escape single quotes in the filename for rofi (optional, but good practice)
    escaped_filename=$(printf '%s' "$filename" | sed "s/'/'\\\\''/g")
    # Add the filename and icon (full path for image preview)
    ROFI_INPUT+="$escaped_filename\x00icon\x1f$file\n"
done < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -print0 | sort -z)

# Check if ROFI_INPUT is empty
if [ -z "$ROFI_INPUT" ]; then
    echo "Error: No image files found in '$WALL_DIR'."
    notify-send "Wallpaper Script Error" "No image files found in '$WALL_DIR'."
    exit 1
fi

# Rofi configuration
ROFI_FLAGS="-dmenu -i -p 'Select Wallpaper'"
# Ensure this theme supports image previews (e.g., rofi-theme-selector or custom)
ROFI_THEME="-theme ~/.config/rofi/themes/KooL_style-1.rasi"

# Choose wallpaper using rofi with image previews
# The 'echo -ne' is crucial for handling the null-separated input correctly with rofi
WALL=$(echo -ne "$ROFI_INPUT" | rofi $ROFI_FLAGS $ROFI_THEME -show-icons)

# Check if a wallpaper was selected
if [ -n "$WALL" ]; then
    echo "Selected wallpaper: $WALL"
    # Construct the full path using WALL_DIR and the selected filename
    FULL_WALL="$WALL_DIR/$WALL"

    # Verify the selected file actually exists
    if [[ -f "$FULL_WALL" ]]; then
        # Apply the wallpaper using swww with a transition animation.
        # Common transition types: "fade", "grow", "wipe", "outer", "simple", "random"
        # Adjust --transition-step and --transition-fps for desired animation.
        "$SWWW_CMD" img "$FULL_WALL" \
            --transition-type "grow" \
            --transition-step 100 \
            --transition-fps 60

        # Send a notification that the wallpaper has been applied
        notify-send -u low -i "$FULL_WALL" "Rofi wallpaper applied..."
    else
        echo "Error: Selected wallpaper file not found at $FULL_WALL"
        notify-send "Wallpaper Script Error" "Selected wallpaper file not found at $FULL_WALL"
    fi
else
    echo "No wallpaper selected."
    notify-send -u low "Wallpaper Script" "No wallpaper selected."
    exit 1
fi


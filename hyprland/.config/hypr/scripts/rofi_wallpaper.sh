#!/bin/bash
MONITOR="HDMI-A-1"
HYPCTL="/usr/bin/hyprctl"
MAGICK="magick"
# Directory containing wallpapers (ensure WALL_DIR is set)
: "${WALL_DIR:=$HOME/Images/Fav}"

# Check if WALL_DIR exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Error: Wallpaper directory '$WALL_DIR' does not exist."
    exit 1
fi

# Initialize ROFI_INPUT
ROFI_INPUT=""

# Initialize ROFI_INPUT
ROFI_INPUT=""

# Check if WALL_DIR exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Error: Wallpaper directory '$WALL_DIR' does not exist."
    exit 1
fi

# Initialize ROFI_INPUT
ROFI_INPUT=""

# Find image files and prepare input for rofi
while IFS= read -r -d $'\0' file; do
    # Extract the filename using basename
    filename=$(basename "$file")
    # Escape single quotes in the filename for rofi (optional, but good practice)
    escaped_filename=$(printf '%s' "$filename" | sed "s/'/'\\\\''/g")
    # Add the filename and icon (full path for image preview)
    ROFI_INPUT+="$escaped_filename\x00icon\x1f$file\n"
done < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -print0 | sort -z)

# Debug: Print ROFI_INPUT to check formatting
# echo "DEBUG: ROFI_INPUT is:"
# echo "$ROFI_INPUT" | cat -vte

# Check if ROFI_INPUT is empty
if [ -z "$ROFI_INPUT" ]; then
    echo "Error: No image files found in '$WALL_DIR'."
    exit 1
fi

# Rofi configuration
ROFI_FLAGS="-dmenu -i -p 'Select Wallpaper'"
ROFI_THEME="-theme ~/.config/rofi/themes/KooL_style-1.rasi" # Ensure this theme supports image previews

# Choose wallpaper using rofi with image previews
WALL=$(echo -ne "$ROFI_INPUT" | rofi $ROFI_FLAGS $ROFI_THEME -show-icons)

# Check if a wallpaper was selected
if [ -n "$WALL" ]; then
    echo "Selected wallpaper: $WALL"
    # Example: Set the wallpaper (replace with your wallpaper setter command)
    # feh --bg-scale "$WALL"
else
    echo "No wallpaper selected."
    exit 1
fi

# Set it
if [[ -n "$WALL" ]]; then
    # Construct the full path using WALL_DIR and the filename
    FULL_WALL="$WALL_DIR/$WALL"
    if [[ -f "$FULL_WALL" ]]; then
        $HYPCTL hyprpaper preload "$FULL_WALL"
        $HYPCTL hyprpaper wallpaper "$MONITOR,$FULL_WALL"
        notify-send -u low -i "$FULL_WALL" "Rofi wallpaper applied..."
    fi
fi

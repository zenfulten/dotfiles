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

# Find image files and prepare input for rofi
while IFS= read -r -d $'\0' file; do
    # Escape single quotes in the file path for rofi
    escaped_file=$(printf '%s' "$file" | sed "s/'/'\\\\''/g")
    # Add the file path and icon (full path for image preview)
    ROFI_INPUT+="$escaped_file\x00icon\x1f$file\n"
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
    if [[ -f "$WALL" ]]; then
        $HYPCTL hyprpaper preload "$WALL"
        $HYPCTL hyprpaper wallpaper "$MONITOR,$WALL"
        notify-send -u low -i "$WALL" "Rofi wallpaper applied..."
    fi
fi

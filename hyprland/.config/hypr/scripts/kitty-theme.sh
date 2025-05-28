#!/bin/bash

# --- Functions for notifications (MUST BE AT THE TOP) ---
# Uses notify-send if available, otherwise falls back to echo.
send_notification() {
    if command -v notify-send &> /dev/null; then
        notify-send -u low "$1" "$2"
    else
        echo "Notification: $1 - $2"
    fi
}

# --- Configuration ---
# Path to your Kitty themes directory.
# This script now expects themes to be in ~/.config/kitty/themes/
KITTY_THEMES_DIR="${HOME}/.config/kitty/themes"

# Your main kitty.conf file path
KITTY_CONF="${HOME}/.config/kitty/kitty.conf"

# Rofi configuration
ROFI_FLAGS="-dmenu -i -p 'Select Kitty Theme'"
# Adjust to your Rofi theme if needed
ROFI_THEME="-theme ~/.config/rofi/themes/config.rasi"

# Initialize Rofi input string
ROFI_INPUT=""

# --- Prerequisites Checks ---

# Check if kitty is installed and in PATH
if ! command -v kitty &> /dev/null; then
    send_notification "Kitty Theme Script Error" "Kitty terminal is not installed or not in your PATH."
    exit 1
fi

# Check if Rofi is installed and in PATH
if ! command -v rofi &> /dev/null; then
    send_notification "Kitty Theme Script Error" "Rofi is not installed or not in your PATH. Please install it."
    exit 1
fi

# Check if ripgrep is installed and in PATH
if ! command -v rg &> /dev/null; then
    send_notification "Kitty Theme Script Error" "Ripgrep (rg) is not installed or not in your PATH. Please install it."
    exit 1
fi

# Check if your custom themes directory exists
if [ ! -d "$KITTY_THEMES_DIR" ]; then
    send_notification "Kitty Theme Script Error" "Kitty themes directory '$KITTY_THEMES_DIR' does not exist."
    echo "Error: Please ensure your themes are located in '$KITTY_THEMES_DIR'."
    exit 1
fi

# Check if kitty.conf includes current-theme.conf
# This line is still useful for general configuration management.
if ! grep -q "include current-theme.conf" "$KITTY_CONF"; then
    send_notification "Kitty Theme Setup Needed" "Your kitty.conf does not include 'include current-theme.conf'. Please add this line to '$KITTY_CONF'."
    echo "Action Required: Please add 'include current-theme.conf' to your kitty.conf file ($KITTY_CONF)."
    exit 1
fi

# --- Gather Kitty Themes for Rofi using Ripgrep ---
# Use rg to list files ending with .conf in the themes directory.
# -l: Only print the filenames of matching files.
# -g '*.conf': Only search for files matching the glob pattern *.conf.
# --files: Lists all files that would be searched (combined with -g, it acts like find).
# --sort path: Sorts the results by file path.
# --files --sort path is crucial for listing files like 'find'
# Make sure your rg version supports --files and --sort path,
# otherwise you might need a simpler rg -l -g '*.conf' | sort.
while IFS= read -r file; do
    # Extract the theme name (filename without .conf extension)
    theme_name=$(basename "$file" .conf)
    # Add the theme name to ROFI_INPUT, separated by newlines for Rofi.
    ROFI_INPUT+="$theme_name\n"
done < <(rg --files --sort path -g '*.conf' "$KITTY_THEMES_DIR")

# Check if any themes were found
if [ -z "$ROFI_INPUT" ]; then
    send_notification "Kitty Theme Script Error" "No .conf theme files found in '$KITTY_THEMES_DIR'. Check your theme installation."
    exit 1
fi

# --- Rofi Selection ---
# Use echo -e to correctly interpret newline characters for Rofi's input.
SELECTED_THEME=$(echo -e "$ROFI_INPUT" | rofi $ROFI_FLAGS $ROFI_THEME)

# --- Apply Selected Theme ---
if [ -n "$SELECTED_THEME" ]; then
    echo "Selected Kitty theme: $SELECTED_THEME"

    # Construct the full path to the selected theme file
    FULL_THEME_PATH="${KITTY_THEMES_DIR}/${SELECTED_THEME}.conf"

    # Verify the theme file exists before attempting to apply
    if [ -f "$FULL_THEME_PATH" ]; then
        # Apply the theme using Kitty's remote control feature.
        # --all: applies to all open Kitty instances.
        # --configured: indicates that the path is to a Kitty config file (theme).
        kitty @ set-colors --all --configured "$FULL_THEME_PATH"
        send_notification "Kitty Theme Applied" "Theme changed to: $SELECTED_THEME"
        cp $FULL_THEME_PATH ~/.config/kitty/current-theme.conf
    else
        send_notification "Kitty Theme Error" "Selected theme file not found: $FULL_THEME_PATH"
        echo "Error: Selected theme file not found at $FULL_THEME_PATH"
        exit 1
    fi
else
    echo "No Kitty theme selected."
    send_notification "Kitty Theme Script" "No Kitty theme selected."
    exit 1
fi

#!/usr/bin/env bash

# --- Configuration ---
# Number of retries for connecting
MAX_RETRIES=5
# Delay between connection attempts (in seconds)
RETRY_DELAY=3
# Scan duration for new devices (in seconds)
SCAN_DURATION=7
# Delay after restarting Bluetooth service (in seconds)
BLUETOOTH_RESTART_DELAY=2

# --- Helper Functions ---

# Function to display notifications
send_notification() {
    notify-send "Bluetooth Manager" "$1"
}

# Function to ensure Bluetooth is powered on and agent is ready
setup_bluetooth() {
    send_notification "Ensuring Bluetooth is ready..."

    bluetoothctl power on || { send_notification "Error: Could not power on Bluetooth."; exit 1; }
    bluetoothctl agent on || { send_notification "Error: Could not enable Bluetooth agent."; exit 1; }
    # As discussed previously, if 'default-agent' causes issues, you might want
    # to uncomment the service restart and delay here, or ensure you're in the 'bluetooth' group.
    # bluetoothctl default-agent || {
    #     send_notification "Error: Could not set default Bluetooth agent. Try adding yourself to 'bluetooth' group: 'sudo usermod -aG bluetooth $USER' then log out and back in."
    #     exit 1
    # }
}

# Function to connect to a device
connect_device() {
    local device_mac="$1"
    send_notification "Attempting to connect to $device_mac..."

    for ((i=1; i<=MAX_RETRIES; i++)); do
        send_notification "Connection attempt $i/$MAX_RETRIES for $device_mac..."
        if bluetoothctl connect "$device_mac" | grep -q "Connection successful"; then
            send_notification "✔  Connected successfully to $device_mac!"
            return 0
        fi
        sleep "$RETRY_DELAY"
    done

    send_notification "✖  Failed to connect to $device_mac after $MAX_RETRIES attempts."
    return 1
}

# Function to disconnect a device
disconnect_device() {
    local device_mac="$1"
    send_notification "Attempting to disconnect $device_mac..."

    # Attempt to disconnect
    bluetoothctl disconnect "$device_mac" &>/dev/null

    # Give a tiny moment for the status to update
    sleep 0.5

    # Check the actual connection status
    if bluetoothctl info "$device_mac" | grep -q "Connected: no"; then
        send_notification "✔ Disconnected successfully from $device_mac!"

        # --- New: Prompt to disable Bluetooth ---
        local disable_bluetooth_prompt=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Turn off Bluetooth completely?")
        if [[ "$disable_bluetooth_prompt" == "Yes" ]]; then
            send_notification "Turning off Bluetooth..."
            if bluetoothctl power off; then
                send_notification "✔ Bluetooth is now OFF."
            else
                send_notification "✖ Failed to turn off Bluetooth."
            fi
        fi
        # --- End New ---

        return 0
    else
        send_notification "! Failed to disconnect from $device_mac (device might still be connected or in a transient state)."
        return 1
    fi
}

# --- Main Execution ---

# 1. Setup Bluetooth environment
setup_bluetooth

# 2. Get available Bluetooth devices and construct Rofi options
DEVICE_OPTIONS=""
CONNECTED_DEVICES=$(bluetoothctl devices Connected | awk '{print $2, $3, $4, $5}')
PAIRED_DEVICES=$(bluetoothctl devices Paired | awk '{print $2, $3, $4, $5}')
ALL_DEVICES=$(bluetoothctl devices | awk '{print $2, $3, $4, $5}')

# Add connected devices with a disconnect option
if [[ -n "$CONNECTED_DEVICES" ]]; then
    while read -r mac name; do
        DEVICE_OPTIONS+="Disconnect $name ($mac) - $mac\n" # Format for rofi
    done <<< "$CONNECTED_DEVICES"
fi

# Add other paired/available devices with a connect option (excluding already listed connected ones)
# We use sort -u to prevent duplicates and filter out MACs already in CONNECTED_DEVICES
DISCONNECT_MACS=$(echo -e "$DEVICE_OPTIONS" | awk '{print $NF}') # Extract MACs from disconnect options
ALL_UNIQUE_DEVICES=$( (echo "$PAIRED_DEVICES"; echo "$ALL_DEVICES") | sort -u )

while read -r mac name; do
    if ! echo "$DISCONNECT_MACS" | grep -q "$mac"; then # Only add if not already in disconnect options
        DEVICE_OPTIONS+="Connect $name ($mac) - $mac\n"
    fi
done <<< "$ALL_UNIQUE_DEVICES"

# 3. Present options to user via Rofi
SELECTED_OPTION=$(echo -e "$DEVICE_OPTIONS" | rofi -dmenu -i -p "Bluetooth Actions:")

[[ -z "$SELECTED_OPTION" ]] && exit 0 # User cancelled

# 4. Parse selected option and perform action
ACTION=$(echo "$SELECTED_OPTION" | awk '{print $1}') # "Connect" or "Disconnect"
DEVICE_MAC=$(echo "$SELECTED_OPTION" | awk '{print $NF}') # Last field is the MAC address

if [[ "$ACTION" == "Connect" ]]; then
    # Before connecting, ensure the device is known/available.
    # This block is similar to the original, but placed before the connect attempt.
    if ! bluetoothctl info "$DEVICE_MAC" &>/dev/null; then
        send_notification "... Device $DEVICE_MAC not found. Scanning for new devices..."
        bluetoothctl scan on &
        SCAN_PID=$!
        sleep "$SCAN_DURATION"
        kill "$SCAN_PID" &>/dev/null
        bluetoothctl scan off &>/dev/null
        if ! bluetoothctl info "$DEVICE_MAC" &>/dev/null; then
            send_notification "✖  Device $DEVICE_MAC still not found after scanning. Please try again."
            exit 1
        fi
    fi
    connect_device "$DEVICE_MAC"
elif [[ "$ACTION" == "Disconnect" ]]; then
    disconnect_device "$DEVICE_MAC"
else
    send_notification "Unknown action selected: $ACTION"
    exit 1
fi


#!/bin/bash

CONFIG_PATH="/home/rio/dotfiles/hyprland/.config/hypr/config/keybind.conf"

if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "Config file not found: $CONFIG_PATH"
  exit 1
fi

declare -A categories=(
  ["wallpaper"]="🖼️ Wallpaper"
  ["shot"]="📷 Screenshots"
  ["clip"]="📋 Clipboard"
  ["waybar"]="💒 Waybar"
  ["rofi"]="🔎 Rofi"
  ["logout"]="🚪 Logout"
  ["workspace"]="🗂️ Workspace"
  ["window"]="🪟 Window Management"
  ["focus"]="👁️ Focus"
  ["resize"]="📐 Resize"
  ["move"]="🚚 Move"
)

modmap() {
  local s="$1"
  s="${s//\$mainMod/SUPER}"
  s="${s//\$SUPER_SHIFT/SUPER SHIFT}"
  s="${s//\$SUPER/SUPER}"
  s="${s//SHIFT/SHIFT}"
  s="${s//ALT/ALT}"
  s="${s//CTRL/CTRL}"
  echo "$s"
}

print_header() {
  local cat="$1"
  if [[ ! "${printed[$cat]}" ]]; then
    echo
    echo "${categories[$cat]}"
    printed[$cat]=1
  fi
}

declare -A printed

grep -E '^(bind|bindm|binde) =' "$CONFIG_PATH" | while IFS= read -r line; do
  # Strip prefix
  line="${line#bind}"
  line="${line#m}"
  line="${line#e}"
  line="${line#=}"
  line="${line#" "}"

  IFS=',' read -r mods key command rest <<< "$line"

  mods="$(echo "$mods" | xargs)"
  key="$(echo "$key" | xargs)"
  command="$(echo "$command" | xargs)"
  rest="$(echo "$rest" | xargs)"

  desc="$command"
  if [[ -n "$rest" ]]; then
    desc+=" $rest"
  fi

  # Map mods vars to names (no plus signs)
  mods=$(modmap "$mods")

  # Combine modifiers and key with spaces only
  if [[ -n "$mods" ]]; then
    keybind="$mods $key"
  else
    keybind="$key"
  fi

  cat="other"
  for k in "${!categories[@]}"; do
    if echo "$desc" | grep -iq "$k"; then
      cat=$k
      break
    fi
  done

  if [[ "$cat" == "other" ]]; then
    if echo "$desc" | grep -Eq 'wallpaper'; then cat="wallpaper"; fi
    if echo "$desc" | grep -Eq 'shot|screenshot|hyprshot'; then cat="shot"; fi
    if echo "$desc" | grep -Eq 'clipboard'; then cat="clip"; fi
    if echo "$desc" | grep -Eq 'waybar'; then cat="waybar"; fi
    if echo "$desc" | grep -Eq 'rofi'; then cat="rofi"; fi
    if echo "$desc" | grep -Eq 'exit|logout|powermenu'; then cat="logout"; fi
    if echo "$desc" | grep -Eq 'workspace'; then cat="workspace"; fi
    if echo "$desc" | grep -Eq 'resize'; then cat="resize"; fi
    if echo "$desc" | grep -Eq 'move|movewindow|swapwindow'; then cat="move"; fi
    if echo "$desc" | grep -Eq 'focus|movefocus'; then cat="focus"; fi
  fi

  print_header "$cat"

  # Print aligned with spaces only
  printf "%-20s : %s\n" "$keybind" "$desc"


done


#!/bin/bash

# Rofi theme
rofi_theme="$HOME/.config/rofi/themes/clipboard.rasi" # Make sure this path is correct for your system
msg='** Neovim Keybinds ** nvim 🚀 Search or press Enter to copy'

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Format & show via rofi
# The sed command removes everything before the '# # NVIM_KEYBINDS # #' marker.
# It then pipes the hardcoded keybinds to rofi.
sed '1,/^# # NVIM_KEYBINDS # #$/d' "$0" | \
rofi -i -dmenu -mesg "$msg" -config "$rofi_theme" | \
awk '{print $1}' | \
wl-copy

exit

# # NVIM_KEYBINDS # #
⌨️ General
Control+b                       : move beginning of line (Insert Mode)
Control+e                       : move end of line (Insert Mode)
Control+h                       : move left (Insert Mode)
Control+l                       : move right (Insert Mode)
Control+j                       : move down (Insert Mode)
Control+k                       : move up (Insert Mode)
Space                           : Disable space (Normal Mode)
ALT+j                           : Move Down (Normal/Insert/Visual Mode)
ALT+k                           : Move Up (Normal/Insert/Visual Mode)
Control+Up                      : Increase Window Height (Normal Mode)
Control+Down                    : Decrease Window Height (Normal Mode)
Control+Left                    : Decrease Window Width (Normal Mode)
Control+Right                   : Increase Window Width (Normal Mode)
Escape                          : Clear highlights (Normal Mode)
Control+s                       : Save File (Insert/Visual/Normal/Select Mode)
Control+W s                     : Split Window Below (Normal Mode)
Control+W v                     : Split Window Right (Normal Mode)
Control+W c                     : Delete Window (Normal Mode)
jk                              : Normal Mode (Insert Mode)
<                               : Better indenting (Visual Mode)
>                               : Better indenting (Visual Mode)
Control+c                       : Toggle Comment (Normal Mode)
Control+c                       : Toggle Comment (Visual Mode)

🔢 Line Numbers
Space+n                         : toggle line number (Normal Mode)
Space+rn                        : toggle relative number (Normal Mode)

🛠️ LSP Keymaps
Space+K                         : Lsp hover (Normal Mode)
Space+gd                        : Lsp definition (Normal Mode)
Space+gr                        : Lsp references (Normal Mode)
Control+.                       : Code Action (Normal Mode)
Space+rm                        : Rename (Normal Mode)

🌳 Neo Tree
Space+e                         : File Explorer (Normal Mode)
Space+rr                        : File Explorer (Normal Mode)
Space+bf                        : Buffer Explorer (Normal Mode)
Space+qe                        : Close File Explorer (Normal Mode)

🔎 Telescope
Space+fp                        : Find Files (Normal Mode)
Space+fg                        : Live Grep (Normal Mode)
Space+Space                     : Find Old Files (Normal Mode)
Space+fz                        : Telescope find in current buffer (Normal Mode)
Space+fb                        : Telescope find buffers (Normal Mode)
Space+fh                        : Telescope help tags (Normal Mode)

↔️ BufferLine
Space+bp                        : Toggle Pin (Normal Mode)
Space+bP                        : Delete Non-Pinned Buffers (Normal Mode)
Space+br                        : Delete Buffers to the Right (Normal Mode)
Space+bl                        : Delete Buffers to the Left (Normal Mode)
Shift+h                         : Prev Buffer (Normal Mode)
Shift+l                         : Next Buffer (Normal Mode)

💻 ToggleTerm
Space+t                         : ToggleTerm (Normal Mode)

↕️ Navigate Panes
Control+k                       : Move up pane
Control+j                       : Move down pane
Control+h                       : Move left pane
Control+l                       : Move right pane

✅ Todo
Space+I                         : TodoTelescope (Normal Mode)

📁 File Actions
Space+fn                        : New File (Normal Mode)

🏠 Alpha
Space+h                         : 󰠅 Alpha (Normal Mode)

❌ Quit
Space+qq                        : Quit All (Normal Mode)

🚀 Flutter Tools
Space+fd                        : Flutter devices (Normal Mode)
Space+fD                        : Flutter detatch (Normal Mode)
Space+ff                        : Flutter run (Normal Mode)
Space+fq                        : Flutter quit (Normal Mode)
Space+fr                        : Flutter reload (Normal Mode)
Space+fR                        : Flutter restart (Normal Mode)
Space+fU                        : Flutter pub upgrade (Normal Mode)
Space+fu                        : Flutter pub get (Normal Mode)

❓ WhichKey
Space+wK                        : whichkey all keymaps (Normal Mode)
Space+wk                        : whichkey query lookup (Normal Mode)

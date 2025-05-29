#!/bin/bash

# Rofi theme
rofi_theme="$HOME/.config/rofi/themes/clipboard.rasi" # Make sure this path is correct for your system
msg='** Yazi Keybinds ** 📁 Search or press Enter to copy'

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Format & show via rofi
# The sed command removes everything before the '# # YAZI_KEYBINDS # #' marker.
# It then pipes the hardcoded keybinds to rofi.
sed '1,/^# # YAZI_KEYBINDS # #$/d' "$0" | \
rofi -i -dmenu -mesg "$msg" -config "$rofi_theme" | \
awk '{print $1}' | \
wl-copy

exit

# # YAZI_KEYBINDS # #
📁 Manager
<Esc> : Exit visual mode, clear selected, or cancel search
<C-[> : Exit visual mode, clear selected, or cancel search
q : Quit the process
Q : Quit the process without outputting cwd-file
<C-c> : Close the current tab, or quit if it's last
<C-z> : Suspend the process

⬆️ Hopping
k : Move cursor up
j : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
<C-u> : Move cursor up half page
<C-d> : Move cursor down half page
<C-b> : Move cursor up one page
<C-f> : Move cursor down one page
<S-PageUp> : Move cursor up half page
<S-PageDown> : Move cursor down half page
<PageUp> : Move cursor up one page
<PageDown> : Move cursor down one page
g g : Move cursor to the top
G : Move cursor to the bottom

🧭 Navigation
h : Go back to the parent directory
l : Enter the child directory
<Left> : Go back to the parent directory
<Right> : Enter the child directory
H : Go back to the previous directory
L : Go forward to the next directory

☑️ Toggle
<Space> : Toggle the current selection state
<C-a> : Select all files
<C-r> : Invert selection of all files

👁️ Visual mode
v : Enter visual mode (selection mode)
V : Enter visual mode (unset mode)

🔍 Seeking
K : Seek up 5 units in the preview
J : Seek down 5 units in the preview

Spotting
<Tab> : Spot hovered file

⚙️ Operation
o : Open selected files
O : Open selected files interactively
<Enter> : Open selected files
<S-Enter> : Open selected files interactively
y : Yank selected files (copy)
x : Yank selected files (cut)
p : Paste yanked files
P : Paste yanked files (overwrite if the destination exists)
- : Symlink the absolute path of yanked files
_ : Symlink the relative path of yanked files
<C--> : Hardlink yanked files
Y : Cancel the yank status
X : Cancel the yank status
d : Trash selected files
D : Permanently delete selected files
a : Create a file (ends with / for directories)
r : Rename selected file(s)
; : Run a shell command
: : Run a shell command (block until finishes)
. : Toggle the visibility of hidden files
s : Search files by name via fd
S : Search files by content via ripgrep
<C-s> : Cancel the ongoing search
z : Jump to a directory via zoxide
Z : Jump to a file/directory via fzf

📊 Linemode
m s : Linemode: size
m p : Linemode: permissions
m b : Linemode: btime
m m : Linemode: mtime
m o : Linemode: owner
m n : Linemode: none

📋 Copy
c c : Copy the file path
c d : Copy the directory path
c f : Copy the filename
c n : Copy the filename without extension

🔎 Filter
f : Filter files

➡️ Find
/ : Find next file
? : Find previous file
n : Goto the next found
N : Goto the previous found

⬆️ Sorting
, m : Sort by modified time
, M : Sort by modified time (reverse)
, b : Sort by birth time
, B : Sort by birth time (reverse)
, e : Sort by extension
, E : Sort by extension (reverse)
, a : Sort alphabetically
, A : Sort alphabetically (reverse)
, n : Sort naturally
, N : Sort naturally (reverse)
, s : Sort by size
, S : Sort by size (reverse)
, r : Sort randomly

🏠 Goto
g h : Go home
g c : Goto ~/.config
g d : Goto ~/Downloads
g <Space> : Jump interactively

🏷️ Tabs
t : Create a new tab with CWD
1 : Switch to the first tab
2 : Switch to the second tab
3 : Switch to the third tab
4 : Switch to the fourth tab
5 : Switch to the fifth tab
6 : Switch to the sixth tab
7 : Switch to the seventh tab
8 : Switch to the eighth tab
9 : Switch to the ninth tab
[ : Switch to the previous tab
] : Switch to the next tab
{ : Swap current tab with previous tab
} : Swap current tab with next tab

📝 Tasks
w : Show task manager

❓ Help
~ : Open help
<F1> : Open help

## Tasks
<Esc> : Close task manager
<C-[> : Close task manager
<C-c> : Close task manager
w : Close task manager
k : Move cursor up
j : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
<Enter> : Inspect the task
x : Cancel the task
~ : Open help
<F1> : Open help

## Spot
<Esc> : Close the spot
<C-[> : Close the spot
<C-c> : Close the spot
<Tab> : Close the spot
k : Move cursor up
j : Move cursor down
h : Swipe to the previous file
l : Swipe to the next file
<Up> : Move cursor up
<Down> : Move cursor down
<Left> : Swipe to the next file
<Right> : Swipe to the previous file
c c : Copy selected cell
~ : Open help
<F1> : Open help

## Pick
<Esc> : Cancel pick
<C-[> : Cancel pick
<C-c> : Cancel pick
<Enter> : Submit the pick
k : Move cursor up
j : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
~ : Open help
<F1> : Open help

## Input
<C-c> : Cancel input
<Enter> : Submit input
<Esc> : Go back the normal mode, or cancel input
<C-[> : Go back the normal mode, or cancel input
i : Enter insert mode
I : Move to the BOL, and enter insert mode
a : Enter append mode
A : Move to the EOL, and enter append mode
v : Enter visual mode
V : Enter visual mode and select all
r : Replace a single character
h : Move back a character
l : Move forward a character
<Left> : Move back a character
<Right> : Move forward a character
<C-b> : Move back a character
<C-f> : Move forward a character
b : Move back to the start of the current or previous word
B : Move back to the start of the current or previous WORD
w : Move forward to the start of the next word
W : Move forward to the start of the next WORD
e : Move forward to the end of the current or next word
E : Move forward to the end of the current or next WORD
<A-b> : Move back to the start of the current or previous word
<A-f> : Move forward to the end of the current or next word
0 : Move to the BOL
$ : Move to the EOL
_ : Move to the first non-whitespace character
^ : Move to the first non-whitespace character
<C-a> : Move to the BOL
<C-e> : Move to the EOL
<Home> : Move to the BOL
<End> : Move to the EOL
<Backspace> : Delete the character before the cursor
<Delete> : Delete the character under the cursor
<C-h> : Delete the character before the cursor
<C-d> : Delete the character under the cursor
<C-u> : Kill backwards to the BOL
<C-k> : Kill forwards to the EOL
<C-w> : Kill backwards to the start of the current word
<A-d> : Kill forwards to the end of the current word
d : Cut the selected characters
D : Cut until the EOL
c : Cut the selected characters, and enter insert mode
C : Cut until the EOL, and enter insert mode
x : Cut the current character
y : Copy the selected characters
p : Paste the copied characters after the cursor
P : Paste the copied characters before the cursor
u : Undo the last operation
<C-r> : Redo the last operation
~ : Open help
<F1> : Open help

## Confirm
<Esc> : Cancel the confirm
<C-[> : Cancel the confirm
<C-c> : Cancel the confirm
<Enter> : Submit the confirm
n : Cancel the confirm
y : Submit the confirm
k : Move cursor up
j : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
~ : Open help
<F1> : Open help

## Completion (cmp)
<C-c> : Cancel completion
<Tab> : Submit the completion
<Enter> : Submit the completion and input
<A-k> : Move cursor up
<A-j> : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
<C-p> : Move cursor up
<C-n> : Move cursor down
~ : Open help
<F1> : Open help

## Help
<Esc> : Clear the filter, or hide the help
<C-[> : Clear the filter, or hide the help
<C-c> : Hide the help
k : Move cursor up
j : Move cursor down
<Up> : Move cursor up
<Down> : Move cursor down
f : Apply a filter for the help items

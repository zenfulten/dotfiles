
#!/bin/bash

rofi_theme="$HOME/.config/rofi/config-emoji.rasi"
msg='✨ Alias Hints – Ctrl+V to paste'

if pidof rofi > /dev/null; then
  pkill rofi
fi

sed '1,/^# # DATA # #$/d' "$0" | \
rofi -i -dmenu -mesg "$msg" -config "$rofi_theme" | \
awk '{print $1}' | \
head -n 1 | \
tr -d '\n' | \
wl-copy

exit

# # DATA # #

🟦 Exit
e      : exit

📂 File Management & Navigation
l      : lsd
ll     : lsd -l
la     : lsd -a
lla    : lsd -la
cd     : z
cat    : bat
cls    : clear
p      : pwd

📝 Editors
nv     : neovide
v      : nvim

🐙 Git Aliases
gc     : git commit -m
gp     : git push
ga     : git add .
gpl    : git pull
gs     : git status
gcl    : git clone
gr     : git restore
gi     : git init

📦 Paru / Pacman Aliases
pacman : paru
pi     : paru -S
pss    : paru -Ss
pu     : paru -Sy
puu    : paru -Syu
pr     : paru -Rns
pq     : paru -Q
pqi    : paru -Qi
pe     : paru -Qe

🖥️ System Utilities
df     : df -h
du     : du -h
free   : free -h
top    : btop

🌐 Network Utilities
ip  : ip a
ping : ping -c 5

💽 Disk Utilities
mount : mount | column -t
umount : umount

⚙️ Systemctl Shortcuts
ss  : systemctl status
sr  : systemctl restart
ssr : systemctl start
ssp : systemctl stop
sen : systemctl enable
sdis : systemctl disable

🐳 Docker Aliases
dps : docker ps
di  : docker images
dstart : docker start
dstop : docker stop
drm : docker rm
drmi : docker rmi

📚 Miscellaneous
hist   : history
cls    : clear


# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


# zoxide

source ~/.zoxide.nu

# yazi 
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}


#alias name = value

# Exit
alias e = exit

# Listing files (using lsd or ls)
alias l = lsd
alias ll = lsd -l
alias la = lsd -a
alias lla = lsd -la

# Change directory with z (jump around)
alias cd = z

# File contents viewer
alias cat = bat

# Clear screen
alias cls = clear

# Print working directory
alias p = pwd

# Neovim and Neovide editors
alias nv = neovide
alias v = nvim

# Git shortcuts
alias gc = git commit -m
alias gp = git push
alias ga = git add .
alias gpl = git pull
alias gs = git status
alias gcl = git clone
alias gr = git restore
alias gi = git init

# Package managers (Paru/AUR helper)
alias pacman = paru
alias pi = paru -S
alias pss = paru -Ss
alias pu = paru -Sy
alias puu = paru -Syu
alias pr = paru -Rns
alias pq = paru -Q
alias pqi = paru -Qi
alias pe = paru -Qe

# System utilities
alias df = df -h
alias du = du -h
alias free = free -h
alias top = btop

# Network utilities
alias ip = ip a
alias ping = ping -c 5

# Disk utilities
alias mount = mount | column -t
alias umount = umount

# Systemctl shortcuts
alias ss = systemctl status
alias sr = systemctl restart
alias ssr = systemctl start
alias ssp = systemctl stop
alias sen = systemctl enable
alias sdis = systemctl disable

# Docker aliases
alias dps = docker ps
alias di = docker images
alias dstart = docker start
alias dstop = docker stop
alias drm = docker rm
alias drmi = docker rmi

# Misc
alias hist = history
alias cls = clear

# fastfetch
alias fs = fastfetch --logo ~/.config/fastfetch/fastfetch/space.png

#kitty-theme
alias ktheme = ~/.config/hypr/scripts/kitty-theme.sh

#hyprland keybinds
alias hint = ~/.config/hypr/scripts/key.sh

#nvim keybinds
alias n-hint = ~/.config/nvim/lua/scripts/hint.sh

#shell 
source ~/.config/nushell/random-script.nu

# themes
let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    # eg) {|| if $in { 'light_cyan' } else { 'light_gray' } }
    bool: light_cyan
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: white bg: red attr: b}
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
}

$env.config = {
    show_banner: false
    
    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }
    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages


    color_config: $dark_theme

}

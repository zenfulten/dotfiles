eval "$(starship init bash)"
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#starship
eval "$(zoxide init bash)"
#!/bin/bash

# Check if the script was called with "bash" as an argument
if [ "$1" = "bash" ]; then
  # Launch bash
  exec bash
else
  # Check if nu is installed
  if command -v nu &> /dev/null; then
    # Launch nu
    exec nu
  else
    echo "nu is not installed. Please install it to use this script."
  fi
fi

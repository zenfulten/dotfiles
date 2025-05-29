
# List all scripts in the directory
let scripts = ls ~/.config/nushell/scripts/*.sh | get name

# Pick one at random
let chosen = $scripts | shuffle | first

# Execute the chosen script
bash $chosen


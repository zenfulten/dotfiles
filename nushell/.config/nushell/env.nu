# env.nu
#
# Installed by:
# version = "0.102.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
use std "path add"

zoxide init nushell | save -f ~/.zoxide.nu

# Add ~/.local/bin to the beginning of the PATH
path add ($env.HOME | path join ".local" "bin")

path add ($env.HOME | path join ".sdk" "jdk-24.0.1" "bin")

path add ($env.HOME | path join ".sdk" "go" "bin")

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join ".flutter" "flutter" "bin")


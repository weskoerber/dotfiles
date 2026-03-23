# config.nu
#
# Installed by:
# version = "0.104.1"
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
use std/config *

$env.config = {
  buffer_editor: "nvim"
  edit_mode: "vi"
  show_banner: false
}

alias g = git
alias v = nvim

alias zvm = zvm.sh

alias org = nvim ($env.HOME | path join "Documents/org") +"Org agenda a"

mkdir ($nu.data-dir | path join "vendor/autoload")

starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# Initialize the PWD hook as an empty list if it doesn't exist
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []
$env.config.hooks.env_change.PWD ++= [{||
  if (which direnv | is-empty) {
    # If direnv isn't installed, do nothing
    return
  }

  direnv export json | from json | default {} | load-env
  # If direnv changes the PATH, it will become a string and we need to re-convert it to a list
  $env.PATH = do (env-conversions).path.from_string $env.PATH
}]

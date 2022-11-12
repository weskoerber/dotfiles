#!/bin/sh

# Source the environment variables
source ./env.sh

NVIM_INSTALL_DIR="${NVIM_INSTALL_DIR:-$HOME/.config/nvim}"
GIT_CONFIG_DIR="$HOME/.config/git"

# $1: install dir
# $2: application binary name
# $3: application pretty name
function install() {
    if [ -h "$1" ]; then
        echo "  $3 is already configured; skipping."
    elif [ -d "$1" ]; then
        echo "! Found local $3 config. (Re)move '$1' and retry."
    else
        echo "+ Installing $3 configuration at '$1'"
        ln -s "$(pwd)/$2" "$1"
    fi
}

install "$NVIM_INSTALL_DIR" "nvim" "Neovim"
install "$GIT_CONFIG_DIR" "git" "Git"

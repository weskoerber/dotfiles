#!/bin/sh

# $1: install dir
# $2: application binary name
# $3: application pretty name
install() {
    if [ -h "$1" ]; then
        echo "  $3 is already configured; skipping."
    elif [ -d "$1" ]; then
        echo "! Found local $3 config. (Re)move '$1' and retry."
    else
        echo "+ Installing $3 configuration at '$1'"
        ln -s "$(pwd)/$2" "$1"
    fi
}

mkdir -p "$HOME/.cache/zsh"

install "$HOME/.config/nvim" "nvim" "Neovim"
install "$HOME/.config/git" "git" "Git"
install "$HOME/.config/zsh" "zsh" "zsh"
install "$HOME/.config/antigen" "antigen" "antigen"
install "$HOME/.config/shell" "shell" "profile, aliasrc"

ln -s "$HOME/.config/shell/profile" "$HOME/.zprofile"

#!/bin/sh

g_all=0
g_scripts=0

usage() {
  target=$(basename $0)
  printf "%s - %s\n\n" "$target" "Install configs"
  printf "%s $(tput bold)[OPTIONS] <PATH> <BINARY> <NAME>$(tput sgr0)\n\n" "$target"
  printf "$(tput bold)OPTIONS:$(tput sgr0)\n"
  printf "  --all, -a      Install all configs\n"
  printf "  --scripts, -s  Install scripts and exit\n"
  printf "  --help, -h     Print usage\n"
  printf "  --usage        Print usage\n\n"
  printf "$(tput bold)PATH:$(tput sgr0)\n"
  printf "  Path to the target config (e.g. ~/.config/tmux)\n\n"
  printf "$(tput bold)BINARY$(tput sgr0):\n"
  printf "  Name of the binary to which the configs belong\n\n"
  printf "$(tput bold)NAME$(tput sgr0):\n"
  printf "  Pretty name of the application to which the configs belong\n"
}

install_all() {
  mkdir -p "$HOME/.cache/zsh"

  install "$HOME/.config/nvim" "nvim" "Neovim"
  install "$HOME/.config/git" "git" "Git"
  install "$HOME/.config/zsh" "zsh" "zsh"
  install "$HOME/.config/shell" "shell" "profile, aliasrc"
  install "$HOME/.config/tmux" "tmux" "Tmux"
  install "$HOME/.config/kitty" "kitty" "Kitty"
  install "$HOME/.config/starship.toml" "starship.toml" "Starship"
  install "$HOME/.config/lazygit" "lazygit" "Lazygit"
  install "$HOME/.config/neomutt" "neomutt" "Neomutt"
  mkdir -p "$HOME/.local/share/neomutt/mail/"

  install "$HOME/.config/hypr" "hypr" "Hyprland"
  install "$HOME/.config/wofi" "wofi" "Wofi"
  install "$HOME/.config/waybar" "waybar" "Waybar"

  install "$HOME/.zprofile" "shell/profile" "Zsh profile"
}

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

install_scripts() {
  fd -a -e sh . .local/bin -x ln -s {} $HOME/.local/bin
}

# process_options
for arg in $@;
do
  case $arg in
    "--usage" | "--help" | "-h")
      usage
      exit 0
      ;;
    "--all" | "-a")
      g_all=1
      shift 1
      ;;
    "--scripts" | "-s")
      g_scripts=1
      shift 1
      ;;
  esac
done

if [ $g_all -eq 1 ]; then
  echo "installing all"
  install_all
fi

if [ $g_scripts -eq 1 ]; then
  echo "installing scripts"
  install_scripts
  exit 0
fi

if [ $# -lt 3 ]; then
  usage
  exit 1
else
  install $@
fi

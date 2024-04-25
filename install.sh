#!/bin/sh

g_all=0
g_scripts=0
g_services=0
g_verbose=0

fc_red=$(tput setaf 9)
f_reset=$(tput sgr0)

info() {
  echo "inf: ${1}" >&2
}

vlog() {
  [ $g_verbose -eq 1 ] && echo "vrb: ${1}" >&2
}

elog() {
  echo "${fc_red}err: ${1}${f_reset}" >&1
}

die() {
  elog "${1}"
  exit 1
}

usage() {
  target=$(basename $0)
  printf "%s - %s\n\n" "$target" "Install configs"
  printf "%s $(tput bold)[OPTIONS] <PATH> <BINARY> <NAME>$(tput sgr0)\n\n" "$target"
  printf "$(tput bold)OPTIONS:$(tput sgr0)\n"
  printf "  --all, -a       Install all configs\n"
  printf "  --scripts, -s   Install scripts and exit\n"
  printf "  --services, -t  Install systemd services and exit (requires root)\n"
  printf "  --help, -h      Print usage\n"
  printf "  --usage         Print usage\n\n"
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

  install "$HOME/.config/hypr" "hypr" "Hyprland"
  install "$HOME/.config/wofi" "wofi" "Wofi"
  install "$HOME/.config/waybar" "waybar" "Waybar"

  install "$HOME/.zprofile" "shell/profile" "Zsh profile"

  install "$HOME/.config/zls.json" "zls/zls.json" "Zls config"
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
  prefix="$HOME/.local/bin"
  local_prefix=$(dirname $(realpath $0))
  local_prefix="${local_prefix%/}/.local/bin"

  echo "${local_prefix}"

  for name in $(fd -e sh . .local/bin -x basename); do
    dest="${prefix%/}/${name}"
    src="${local_prefix%/}/${name}"

    if [ -h "$dest" ]; then
      echo "  $name is already installed; skipping."
    elif [ -f "$dest" ]; then
      echo "! Found local script $name. (Re)move $dest and retry."
    else
      echo "+ Installing script $name."
      ln -s "$src" "$dest"
    fi
  done
}

install_services() {
  if [ $(id -u) -ne $(id -u root) ]; then
    die "This script requires root"
  fi

  prefix="/etc/systemd"
  local_prefix=$(dirname $(realpath $0))

  vlog "Installing service scripts"
  scripts=$(fd -t f . ./systemd/scripts -x basename)
  for script in $scripts; do
    dst="/usr/local/bin/${script}"
    src="${local_prefix%/}/systemd/scripts/${script}"
    vlog "  installing ${script}"
    ln -sf $src $dst
  done

  vlog "Installing system services"

  services=$(fd -t f . ./systemd/system -x basename)
  for service in $services; do
    dst="${prefix%/}/system/${service}"
    src="${local_prefix%/}/systemd/system/${service}"

    vlog "  installing ${service}"
    ln -sf $src $dst

    vlog "  reloading systemd daemon"
    systemctl daemon-reload
  done
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
    "--services" | "-t")
      g_services=1
      shift 1
      ;;
    "--verbose" | "-v")
      g_verbose=1
      shift 1
      ;;
  esac
done

if [ $g_all -eq 1 ]; then
  echo "installing all"
  install_all
  exit 0
fi

if [ $g_scripts -eq 1 ]; then
  echo "installing scripts"
  install_scripts
  exit 0
fi

if [ $g_services -eq 1 ]; then
  info "Installing system services"
  install_services
  exit $?
fi

if [ $# -lt 3 ]; then
  usage
  exit 1
else
  install $@
fi

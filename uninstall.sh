#!/bin/sh

g_args=$@
g_force=0

usage() {
  target=$(basename $0)
  printf "%s - %s\n\n" "$target" "Remove symlinked configs"
  printf "%s $(tput bold)[OPTIONS] <PATH> <BINARY> <NAME>$(tput sgr0)\n\n" "$target"
  printf "$(tput bold)OPTIONS:$(tput sgr0)\n"
  printf "  --force, -f    Remove config, even if it's not a symlink.\n"
  printf "  --help, -h     Print usage\n"
  printf "  --usage        Print usage\n\n"
  printf "$(tput bold)PATH:$(tput sgr0)\n"
  printf "  Path to the target config (e.g. ~/.config/tmux)\n\n"
  printf "$(tput bold)BINARY$(tput sgr0):\n"
  printf "  Name of the binary to which the configs belong\n\n"
  printf "$(tput bold)NAME$(tput sgr0):\n"
  printf "  Pretty name of the application to which the configs belong\n"
}

# $1: install dir
# $2: application binary name
# $3: application pretty name
uninstall() {
  echo "Attempting to uninstall configuration for $3"

  if ! [ -a "$1" ]; then
    echo "!  Config for $3 not found at $1; skipping"
    return
  fi

  # Note: if the user has an existing config, we want to
  # make sure we don't remove it. unlink won't remove
  # directories, but we should catch the case anyway and
  # print a message to the user.
  if [ -L "$1" ]; then
    echo "+ Uninstalling symlinked config from $1"
    unlink $1
  else
    if [ $g_force -eq 1 ]; then
      echo "! Forcing removal of config for $3"
      rmdir $1
    else
      echo "  Possible user config for $3; skipping"
    fi
  fi
}

uninstall_scripts() {
  fd -e sh . .local/bin -x rm -v ~/{}
}

# process_options
for arg in $@;
do
  case $arg in
    "--usage" | "--help" | "-h")
      usage
      exit 0
      ;;
    "--force" | "-f")
      g_force=1
      shift 1
      ;;
  esac
done

if [ $# -lt 3 ]; then
  usage
  exit 1
fi

uninstall $@

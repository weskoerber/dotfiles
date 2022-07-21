#!/bin/sh

# Source the environment variables
source ./env.sh

ln -s "$(pwd)/nvim" "${NVIM_INSTALL_DIR:-$HOME/.config/nvim}"


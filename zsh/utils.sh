#!/usr/bin/zsh

# $1: directory to check
dir_exists() {
    [ -d "$1" ] && echo 0 || echo 1
}

# $1: directory to check
file_exists() {
    [ -f "$1" ] && echo 0 || echo 1
}

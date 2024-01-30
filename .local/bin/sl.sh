#!/bin/sh

err() {
    echo "$1" >&2
}
if [ $# -ne 2 ]; then
    err "invalid arguments"
    exit 1
fi

ln -s $(realpath $1) $(realpath $2)

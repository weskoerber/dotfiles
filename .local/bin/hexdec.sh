#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Error: missing argument"
    exit 1
fi

res=$(printf "%d\n" "$1")

if [ $? -eq 0 ]; then
    echo "$res"
fi

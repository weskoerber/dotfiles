#!/bin/sh

num_updates=$(cat /var/local/package-updates)

if [ -z "$num_updates" ]; then
    num_updates=0
fi

cat <<json
{"text":${num_updates}, "alt":"alttext", "tooltip":"run 'pacman -Qu' \nto list updates", "class":"updates", "percentage":0}
json

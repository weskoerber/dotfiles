#!/bin/sh

state_file="$XDG_STATE_HOME/wayland-pipewire-idle-inhibit"

state="$(cat "$state_file")" || exit 1
percentage=0

if [ "$state" = 'ENABLED' ]; then
    percentage=100
fi

jq --unbuffered --compact-output --null-input \
    --arg text "$state" \
    --arg alt "$state" \
    --arg tooltip "$state" \
    --arg class '' \
    --arg percentage $percentage \
    '{
        text: $text,
        alt: $alt,
        tooltip: $tooltip,
        class: $class,
        percentage: $percentage
    }'

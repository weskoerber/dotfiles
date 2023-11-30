#!/bin/sh

readonly selection=$(fzf <<< $(cmake --help-command-list)$(cmake --help-variable-list)$(cmake --help-property-list)$(cmake --help-module-list)$(cmake --help-policy-list))
page=""

try_get_page() {
    page=$(cmake --help-"$1" "$selection")

    if [ $? -ne 0 ]; then
        page=""
    fi
}

try_get_page "command"
if [ -n "$page" ]; then
    less <<< $page
    exit 0
fi

try_get_page "variable"
if [ -n "$page" ]; then
    less <<< $page
    exit 0
fi

try_get_page "property"
if [ -n "$page" ]; then
    less <<< $page
    exit 0
fi

try_get_page "module" ||
if [ -n "$page" ]; then
    less <<< $page
    exit 0
fi

try_get_page "policy"
if [ -n "$page" ]; then
    less <<< $page
    exit 0
fi

if [ -z "$page" ]; then
    echo "Error: Page not found"
    exit 1
fi

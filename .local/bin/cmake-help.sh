#!/bin/sh

readonly selection=$(fzf <<< $(cmake --help-command-list)$(cmake --help-variable-list)$(cmake --help-property-list)$(cmake --help-module-list)$(cmake --help-policy-list))
page=""

try_get_page() {
    page=$(cmake --help-"$1" "$selection")

    if [ $? -ne 0 ]; then
        page=""
    fi

    return $?
}

try_get_page "command" ||
    try_get_page "variable" ||
    try_get_page "property" ||
    try_get_page "module" ||
    try_get_page "policy"

if [ -z "$page" ]; then
    echo "Error: Page not found"
    exit 1
fi

less <<< $page

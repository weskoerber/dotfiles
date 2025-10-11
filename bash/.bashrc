# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.config/shell/aliasrc

[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"
HISTTIMEFORMAT="[%F %T]"

eval "$(starship init bash)"

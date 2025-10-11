# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.config/shell/aliasrc

[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"
HISTTIMEFORMAT="[%F %T]"
HISTCONTROL=ignoreboth

shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s histappend
shopt -s histverify

bind 'set bell-style none'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-stats on'
bind 'TAB:menu-complete'

eval "$(starship init bash)"

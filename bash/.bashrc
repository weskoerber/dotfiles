# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.config/shell/aliasrc
. ~/.config/shell/initrc

HISTSIZE=100000
HISTFILESIZE=1000000000
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
bind '"\e[Z":menu-complete-backward'

if command -v fzf > /dev/null; then
    eval "$(fzf --bash)"
fi

if command -v starship > /dev/null; then
    [ "$STARSHIP_DISABLED" = 'true' ] || eval "$(starship init bash)"
fi


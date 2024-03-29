# Source profile
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi

# Zsh opts
autoload -U colors && colors
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Key bindings
export KEYTIMEOUT=1
bindkey '^R' history-incremental-pattern-search-backward

# vi mode
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select


################
# History file #
################
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTTIMEFORMAT="[%F %T]"
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups

################
# Load aliases #
################
if [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
fi

#####################
# first run install #
#####################
source "${ZDOTDIR:-$HOME/.config/zsh}/first_run.sh"

if [ -z "$LS_COLORS" ]; then
    if ! [ -f "$HOME/.dir_colors" ]; then
        echo "TERM alacritty" > "$HOME/.dir_colors"
        dircolors --print-database >> "$HOME/.dir_colors"
    fi

    eval $(dircolors -b "$HOME/.dir_colors")
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

fpath=(~/.config/zsh/plugins/zsh-users/zsh-completions/src $fpath)
source ~/.config/zsh/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# This line must stay at the end of zshrc!
source ~/.config/zsh/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

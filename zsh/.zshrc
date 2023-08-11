# Source profile
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi

# Zsh opts
autoload -U colors && colors
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
setopt CORRECT
setopt CORRECT_ALL

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
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

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

fpath=(~/.config/zsh/plugins/zsh-users/zsh-completions/src $fpath)
source ~/.config/zsh/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# This line must stay at the end of zshrc!
source ~/.config/zsh/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

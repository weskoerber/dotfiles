#####################
### powerlevel10k ###
#####################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/powerlevel10k/powerlevel10k.zsh-theme" ]; then
   source "${XDG_DATA_HOME:-$HOME/.local/share}/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Source profile
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi

############
# Autoload #
############
# autoload -U colors && colors
# setopt autocd
# autoload -U compinit && compinit

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
source "${ZDOTDIR:-$HOME/.config/zsh}/first_run"

########################
### Load zsh plugins ###
########################
if [ -f "${ADOTDIR:-$HOME/.config/antigen}/antigenrc" ]; then
    source "${ADOTDIR:-$HOME/.config/antigen}/antigenrc"
fi

if [ -z "$LS_COLORS" ]; then
    if ! [ -f "$HOME/.dir_colors" ]; then
        echo "TERM alacritty" > "$HOME/.dir_colors"
        dircolors --print-database >> "$HOME/.dir_colors"
    fi

    eval $(dircolors -b "$HOME/.dir_colors")
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

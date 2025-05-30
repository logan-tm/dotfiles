# Takes all the alias files in this directory and sources them.
# Assumes that every .zsh file in this directory is meant to be sourced.

# thisdir="${funcsourcetrace[1]%/*}"
# thisfile="${funcsourcetrace[1]%:0}"

# # echo "DIR:  $thisdir"
# # echo "FILE: $thisfile"

# for file in "$thisdir"/*.zsh; do
#   if [[ $file != $thisfile ]]; then
#     # echo "SUBFILE: $file"
#     source $file
#   fi  
# done

XDG_CONFIG_HOME="/home/lm/.config"

source_if_exists () {
	if test -r "$1"; then
		source "$1"
	else
		echo "Can't source $1"
	fi
}

source_if_exists $HOME/.env.sh # Sets $DOTFILES, $ZSH_DEBUG and other env variables
source_if_exists $DOTFILES/util/print.sh

local debug=${ZSH_DEBUG:-1}
(($debug > 0)) && pretty_print info "Debug mode enabled (can disable in ~/.env.sh)"

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

plugins=(git docker ssh-agent zsh-autosuggestions fast-syntax-highlighting jsontools)

export EDITOR=vim
VISUAL="$EDITOR"

# ===============================================================================

(($debug > 0)) && pretty_print info "Starting brew"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
(($debug > 0)) && pretty_print clear_last && pretty_print success "Brew started"

# ===============================================================================

(($debug > 0)) && pretty_print info "Sourcing configs"
source_if_exists $DOTFILES/zsh/util.zsh
for file in $(find $DOTFILES -maxdepth 2 -name "config.zsh"); do
	source_if_exists $file
done
(($debug > 0)) && pretty_print clear_last && pretty_print success "Sourced configs"

# ===============================================================================

(($debug > 0)) && pretty_print info "Sourcing oh-my-zsh"
export ZSH="$HOME/.oh-my-zsh"
source_if_exists $ZSH/oh-my-zsh.sh
(($debug > 0)) && pretty_print clear_last && pretty_print success "Sourced oh-my-zsh"

# ===============================================================================

(($debug > 0)) && pretty_print info "Loading compinit"
autoload -Uz compinit; compinit
autoload -U +X bashcompinit && bashcompinit
(($debug > 0)) && pretty_print clear_last && pretty_print success "Loaded compinit"

# ===============================================================================

(($debug > 0)) && pretty_print info "Starting starship"
eval "$(starship init zsh)"
(($debug > 0)) && pretty_print clear_last && pretty_print success "Starship started"

# ===============================================================================

(($debug > 0)) && pretty_print info "Sourcing aliases"
for file in $(find $DOTFILES -maxdepth 2 -name "alias.zsh"); do
	source_if_exists $file
done
(($debug > 0)) && pretty_print clear_last && pretty_print success "Aliases sourced"

# ===============================================================================

(($debug > 0)) && pretty_print info "Evaluating fzf"
eval "$(fzf --zsh)"
(($debug > 0)) && pretty_print clear_last && pretty_print success "Evaluated fzf"

# ===============================================================================

(($debug > 0)) && pretty_print space_hr && pretty_print success 'All set!'
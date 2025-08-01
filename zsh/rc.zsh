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

local debug=${ZSH_DEBUG:-1}

run_step () {
  local desc=$1; shift
  if (($debug <= 0)); then
    $@ > /dev/null 2>&1
  else
  	pretty_print process "$desc"
		if ! $@; then
			pretty_print clear_last && pretty_print error "Failed: $desc"
			# continue anyway for now
		else
			pretty_print clear_last && pretty_print success "$desc"
		fi
  fi
}

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


(($debug > 0)) && pretty_print info "Debug mode enabled (can disable in ~/.env.sh)"
pretty_print space_hr

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

zstyle :omz:plugins:ssh-agent quiet yes # suppress ssh-agent message on startup
plugins=(git docker ssh-agent zsh-autosuggestions fast-syntax-highlighting jsontools)

export EDITOR=vim
VISUAL="$EDITOR"

# ===============================================================================

run_step "Starting brew" eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ===============================================================================

source_configs () {
	for file in $(find $DOTFILES -maxdepth 2 -name "config.zsh"); do
		source_if_exists $file
	done
}
run_step "Sourcing configs" source_configs

# ===============================================================================

source_oh_my_zsh () {
	export ZSH="$HOME/.oh-my-zsh"
	source_if_exists $ZSH/oh-my-zsh.sh
}
run_step "Sourcing oh-my-zsh" source_oh_my_zsh

# ===============================================================================

load_compinit () {
	autoload -Uz compinit; compinit
	autoload -U +X bashcompinit && bashcompinit
}
run_step "Loading compinit" load_compinit

# ===============================================================================

run_step "Starting starship" eval "$(starship init zsh)"

# ===============================================================================

source_aliases () {
	for file in $(find $DOTFILES -maxdepth 2 -name "alias.zsh"); do
		source_if_exists $file
	done
}
run_step "Sourcing aliases" source_aliases

# ===============================================================================

run_step "Evaluating fzf" eval "$(fzf --zsh)"

# ===============================================================================

run_step "Sourcing ~/.local/bin/env" . "$HOME/.local/bin/env"

# ===============================================================================

(($debug > 0)) && pretty_print space_hr && pretty_print success 'All set!'
# . "$HOME/.local/bin/env"

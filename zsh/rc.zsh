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

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# plugins setup (may move to antigen)
plugins=(git docker ssh-agent zsh-autosuggestions zsh-syntax-highlighting jsontools)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source_if_exists () {
	if test -r "$1"; then
		source "$1"
	else
		echo "Can't source $1"
	fi
}

source_if_exists $HOME/.local/bin/env
source_if_exists $HOME/.env.sh # Sets $DOTFILES and other env variables
source_if_exists $DOTFILES/antigen/antigen.zsh
source_if_exists $DOTFILES/antigen/.antigenrc >/dev/null
source_if_exists $DOTFILES/brew/install.zsh

# configs (eventually replace this with function that scans dotfiles for 'config.zsh')
source_if_exists $DOTFILES/zsh/util.zsh
for file in $(find $DOTFILES -maxdepth 2 -name "config.zsh"); do
	# source_if_exists $file
	source_if_exists $file
done
# source_if_exists $DOTFILES/bat/config.zsh
# source_if_exists $DOTFILES/fzf/config.zsh
# source_if_exists $DOTFILES/navi/config.zsh
# source_if_exists $DOTFILES/nvm/config.zsh
# source_if_exists $DOTFILES/yazi/config.zsh

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source_if_exists $ZSH/oh-my-zsh.sh


# For running cargo commands
# . $HOME/.cargo/env




export EDITOR=vim
VISUAL="$EDITOR"

# export FLYCTL_INSTALL="/home/logan/.fly"
# export PATH="$FLYCTL_INSTALL/bin:$PATH"

# fpath+=(~/.config/hcloud/completion/zsh)
autoload -Uz compinit; compinit
# compdef _flyctl fly

export WIN_HOME="/mnt/c/Users/logan"
export ANDROID_HOME="$WIN_HOME/AppData/Local/Android/Sdk"

autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform



# for i in {0..255}; do print -Pn %K{$i} %k%F{$i}${(l:3::0:)i}%f  ${${(M)$((i%6)):#3}:+\\n}; done

# Added to the bottom of this file due to bindkey issues.
eval "$(starship init zsh)"
source_if_exists $DOTFILES/zsh/aliases/index.zsh
eval "$(fzf --zsh)"
. "$HOME/.local/bin/env"

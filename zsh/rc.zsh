source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}
source_if_exists $HOME/.env.sh # Sets $DOTFILES and other env variables
source_if_exists $DOTFILES/zsh/aliases/index.zsh
source_if_exists $DOTFILES/antigen/antigen.zsh
source_if_exists $DOTFILES/antigen/.antigenrc >/dev/null

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
plugins=(git docker ssh-agent zsh-autosuggestions zsh-syntax-highlighting jsontools)

# For running cargo commands
# . $HOME/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source_if_exists $ZSH/oh-my-zsh.sh

export EDITOR=vim
VISUAL="$EDITOR"

# export FLYCTL_INSTALL="/home/logan/.fly"
# export PATH="$FLYCTL_INSTALL/bin:$PATH"

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fpath+=(~/.config/hcloud/completion/zsh)
autoload -Uz compinit; compinit
# compdef _flyctl fly

export WIN_HOME="/mnt/c/Users/logan"
export ANDROID_HOME="$WIN_HOME/AppData/Local/Android/Sdk"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# for i in {0..255}; do print -Pn %K{$i} %k%F{$i}${(l:3::0:)i}%f  ${${(M)$((i%6)):#3}:+\\n}; done

DOTFILES="$HOME/.dotfiles"

run_step () {
  local desc=$1; shift
  if (($debug <= 0)); then
    $@ > /dev/null 2>&1
  else
  	pretty_print process "$desc"
		if ! $@; then
			pretty_print clear_last && pretty_print fail "Failed: $desc"
			# continue anyway for now
		else
			pretty_print clear_last && pretty_print success "$desc"
		fi
  fi
}

XDG_CONFIG_HOME="/home/lm/.config"

# Minecraft needs this to run with nvidia GPU on Linux
__NV_PRIME_RENDER_OFFLOAD=1
__GLX_VENDOR_LIBRARY_NAME=nvidia

source $DOTFILES/util/index.sh
source_if_exists $HOME/.env.sh # Sets $DOTFILES, $ZSH_DEBUG and other env variables
local debug=${ZSH_DEBUG:-1}
source_if_exists $DOTFILES/zsh/util.zsh



if [[ $debug -gt 0 ]]; then 
	pretty_print info "Debug mode enabled (can disable in ~/.env.sh)"
	pretty_print space_hr
fi;

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# zstyle :omz:plugins:ssh-agent quiet yes # suppress ssh-agent message on startup
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # auto complete case insensitive
# plugins=(git docker ssh-agent jsontools)
source_if_exists $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source_if_exists $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(git docker ssh-agent zsh-autosuggestions fast-syntax-highlighting jsontools)

# export EDITOR=vim
export EDITOR=gedit
VISUAL="$EDITOR"
source_if_exists $DOTFILES/zsh/key-bindings.zsh

# ===============================================================================

source_configs () {
	for file in $(find $DOTFILES -maxdepth 2 -name "config.zsh"); do
		source_if_exists $file
	done
}
run_step "Sourcing configs" source_configs

# ===============================================================================

source_aliases () {
	for file in $(find $DOTFILES -maxdepth 2 -name "alias.zsh"); do
		source_if_exists $file
	done
}
run_step "Sourcing aliases" source_aliases

# ===============================================================================

load_compinit () {
	# autoload -Uz compinit; compinit
	autoload -Uz compinit;

	if [[ -n $HOME/.cache/zsh/zcompdump-$ZSH_VERSION(#qN.mh+24) ]]; then
		compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
	else
		compinit -C;
	fi; 
	autoload -U +X bashcompinit && bashcompinit
}
run_step "Loading compinit" load_compinit

# ===============================================================================

run_step "Starting starship" eval "$(starship init zsh)"

# ===============================================================================

run_step "Evaluating fzf" eval "$(fzf --zsh)"
run_step "Evaluating zoxide" eval "$(zoxide init zsh)"

# ===============================================================================

setup_android_sdk_paths () {
	# Android SDK paths
	export ANDROID_HOME=$HOME/Applications/Android/sdk
	export CAPACITOR_ANDROID_STUDIO_PATH=/opt/android-studio/bin/studio.sh
	export PATH=$PATH:$ANDROID_HOME/emulator
	export PATH=$PATH:$ANDROID_HOME/platform-tools
	export PATH=$PATH:$ANDROID_HOME/tools
	export PATH=$PATH:$ANDROID_HOME/tools/bin
}
run_step "Exporting Android variables..." setup_android_sdk_paths
# ===============================================================================

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# ===============================================================================

# (($debug > 0)) && pretty_print space_hr && pretty_print success 'All set!'
if [[ $debug -gt 0 ]]; then 
	pretty_print space_hr
	pretty_print success "All set!"
else
	fastfetch -l small
fi;
# . "$HOME/.local/bin/env"


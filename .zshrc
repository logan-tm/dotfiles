DOTS=$( dirname -- "$( readlink -f -- "$0"; )"; )

# Set up custom aliases
source $DOTS/alias.zsh

# Point to the installed antigen file
# (will appear after init.sh is run)
source ~/.antigen.zsh

# Kick off antigen
antigen init $DOTS/.antigenrc

# Set VIM as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Point starship to the toml file within the dotfiles repo
export STARSHIP_CONFIG="$DOTS/starship.toml"

# Point vim to the .vimrc file within the dotfiles repo
export MYVIMRC="$DOTS/.vimrc"
export VIMINIT="source $MYVIMRC"

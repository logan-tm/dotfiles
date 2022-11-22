# save the current working directory, which is also
# where the directory has been pulled down to
origin=$pwd
cwd=$( dirname -- "$( readlink -f -- "$0"; )"; )
zsh_install='$(sudo apt-get install -y zsh)'
antigen_install='$(curl -L git.io/antigen > .antigen.zsh)'
starship_install='$(curl -sS https://starship.rs/install.sh | sh)'
nvm_install='$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash)'

cd ~

# ===== zsh
# preferred shell
if (( ! $+commands[zsh] )); then
    echo "Zsh not found. Installing zsh..."
    eval $zsh_install
else
    echo "Zsh found."
fi

# ===== antigen
# used for terminal package management
if [ ! -f ~/antigen.zsh ] && [ ! -f ~/.antigen.zsh ]; then
    echo "Antigen not found. Installing in location '~/.antigen.zsh'..."
    eval $antigen_install
else echo "Antigen found."; fi

# ===== starship
# used for custom theming
if (( ! $+commands[starship] )); then
    echo "Starship not found. Installing starship..."
    eval $starship_install
else echo "Starship found."; fi

# ===== nvm
# used for node.js
if [ ! -d ~/.nvm ]; then
    echo "Nvm not found. Installing nvm..."
    eval $nvm_install
else echo "Nvm found."; fi

# TODO: install Python

source $cwd/.zshrc
eval $(starship init zsh)

echo "Initialization complete."
cd $origin

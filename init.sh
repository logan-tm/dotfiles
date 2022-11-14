# save the current working directory, which is also
# where the directory has been pulled down to
cwd=$( dirname -- "$( readlink -f -- "$0"; )"; )

cd ~

echo "Installing zsh..."
sudo apt-get install -y zsh

echo "Installing antigen..."
curl -L git.io/antigen > .antigen.zsh

echo "Sourcing .zshrc file from $cwd..."
echo "source $cwd/.zshrc" > ~/.zshrc

# will be optional in the future: install nvm with init
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

source ~/.zshrc
echo "Initialization complete."
cd $cwd

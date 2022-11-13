# save the current working directory, which is also
# where the directory has been pulled down to
cwd=$(pwd)

cd ~

echo "Installing zsh..."
sudo apt-get install -y zsh

echo "Installing antigen..."
curl -L git.io/antigen > antigen.zsh

echo "Sourcing .zshrc file from $cwd..."
source "$cwd/.zshrc"

# save the current working directory, which is also
# where the directory has been pulled down to
origin=$pwd
cwd=$( dirname -- "$( readlink -f -- "$0"; )"; )
zsh_install='$(sudo apt-get install -y zsh)'
antigen_install='$(curl -L git.io/antigen > .antigen.zsh)'
starship_install='$(curl -sS https://starship.rs/install.sh | sh)'
nvm_install='$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash)'

cd ~

# ===== Get flags for optional installs
while getopts "anp" arg; do
    case $arg in
        a) install_all=true;;
        n) install_nvm=true;;
        p) install_py=true;;
    esac
done

# ===== INSTALLATIONS

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
if [ $install_all ] || [ $install_nvm ]; then
    if [ ! -d ~/.nvm ]; then
        echo "Nvm not found. Installing nvm..."
        eval $nvm_install
    else echo "Nvm found."; fi
fi

# ===== python
# TODO: install Python
if [ $install_all ] || [ $install_py ]; then
    echo "Python not yet supported. Coming soon!"
fi

# ===== INSTALLATIONS COMPLETE


# ===== create .zshrc file
# save the original as a backup if it exists and
# have all "important" source commands put there
if [ -f ~/.zshrc ]; then
    echo "Overwriting the .zshrc file. Saving existing file as ~/.zshrc_backup..."
    mv ~/.zshrc ~/.zshrc_backup
else echo "Creating new .zshrc file..."; fi

echo "source $cwd/.zshrc" > ~/.zshrc
echo "source $cwd/alias.zsh" >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

echo "Initialization complete."
cd $origin

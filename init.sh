# save the current working directory, which is also
# where the directory has been pulled down to
origin=$pwd
cwd=$( dirname -- "$( readlink -f -- "$0"; )"; )
zsh_install='$(sudo apt-get install -y zsh)'
antigen_install='$(curl -L git.io/antigen > .antigen.zsh)'
nvm_install='$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash)'
vim_plug_install=`$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)`

cd ~

# ===== Get flags for optional installs
while getopts "an" arg; do
    case $arg in
        a) install_all=true;;
        n) install_nvm=true;;
    esac
done


# ===== starship
# Check to see if starship was installed
# as a separate step
if (( ! $+commands[starship] )); then
    echo "Starship not found. Please install starship with the following command:"
    echo "curl -sS https://starship.rs/install.sh | sh"
    exit 0
fi


# ===== INSTALLATIONS

# ===== zsh
# preferred shell
if (( ! $+commands[zsh] )); then
    echo "Zsh not found. Installing zsh..."
    eval $zsh_install
fi

# ===== antigen
# used for terminal package management
if [ ! -f ~/antigen.zsh ] && [ ! -f ~/.antigen.zsh ]; then
    echo "Antigen not found. Installing in location '~/.antigen.zsh'..."
    eval $antigen_install
fi

# ===== nvm
# used for node.js
if [ $install_all ] || [ $install_nvm ]; then
    if [ ! -d ~/.nvm ]; then
        echo "Nvm not found. Installing nvm..."
        eval $nvm_install
    else echo "Nvm already found. Skipping install..."; fi
fi

# ===== vim plug manager
# used for vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    eval $vim_plug_install
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

echo "Initialization complete. Please source ~/.zshrc to finish setup."
cd $origin

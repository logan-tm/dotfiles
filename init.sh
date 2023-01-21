#!/bin/sh


: '
This script serves as the installation of 90% of a terminal setup.
It will expect the user to install starship (in order to use the toml 
configuration), and will install the following by default:
- zsh (preferred shell)
- antigen (package/theme management)

The following are optional installations that the user may opt into:
- nvm
- google cloud cli (gcloud)
'


# Colors for styling
Color_Off='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Cyan='\033[0;36m'         # Cyan


# Variables for organization
origin=$pwd
cwd=$( dirname -- "$( readlink -f -- "$0"; )"; )


# Links/paths for installs
zsh_install='$(sudo apt-get install -y zsh)'
antigen_install='$(curl -L git.io/antigen > .antigen.zsh)'
nvm_install='$(curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash)'
vim_plug_install='$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)'
google_cloud_install='$(curl -s -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-414.0.0-linux-x86_64.tar.gz)'
google_cloud_extract='$(tar -xf google-cloud-cli-414.0.0-linux-x86_64.tar.gz)'
google_cloud_remove_tar_file='$(rm ~/google-cloud-cli-414.0.0-linux-x86_64.tar.gz)'


# If starship isn't installed, prompt the user to do so and exit
# Requires user input, and the script cannot easily do so for the user
if [ ! -x "$(command -v starship)" ]; then
    echo "Starship not found. Please install starship with the following command:"
    echo "curl -sS https://starship.rs/install.sh | sh"
    exit 0
fi


# Set working directory to ~ and provide a description to the user
cd ~
echo ""


# ===== create .zshrc file
# save the original as a backup if it exists and
# have all "important" source commands put there
if [ -f ~/.zshrc ]; then
    read -p "$(echo $Yellow'Overwrite existing .zshrc file? Existing file will be saved as ~/.zshrc_backup (y/n): '${Color_Off})" overwrite_zsh
    if [ overwrite_zsh = "y" ] || [ overwrite_zsh = "Y" ]; then
        mv ~/.zshrc ~/.zshrc_backup
    fi
else echo "Creating new .zshrc file..."; fi


# Set zshrc file to point to the files in this location
echo "source $cwd/.zshrc" > ~/.zshrc
echo "source $cwd/alias.zsh" >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo "${Green}Done.${Color_Off} Going through installations..."


# ===== INSTALLATIONS

# ===== zsh
# preferred shell
if [ ! -x "$(command -v zsh)" ]; then
    echo "Zsh not found. Installing zsh..."
    eval $zsh_install
fi

# ===== antigen
# used for terminal package management
# (default)
if [ ! -f ~/antigen.zsh ] && [ ! -f ~/.antigen.zsh ]; then
    echo "Antigen not found. Installing in location '~/.antigen.zsh'..."
    eval $antigen_install
fi

# ===== nvm
# used for node.js
if [ -d ~/.nvm ]; then
    echo "${Cyan}Found nvm."
    if [ $overwrite_zsh = "y" ] || [ $overwrite_zsh = "Y" ]; then
        echo -n "${Yellow}Adding nvm lines to .zshrc file..."
        echo '' >> ~/.zshrc
        echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> ~/.zshrc
        echo "${Green}Done.${Color_Off}"
    fi
else
    if [ ! -d ~/.nvm ] && [ ! -x "$(command -v nvm)" ]; then
        read -p "$(echo $Cyan'Nvm not found. Install? (y/n): '${Color_Off})" install_nvm
        if [ $install_nvm = "y" ] || [ $install_nvm = "Y" ]; then eval $nvm_install; fi   
    fi
fi



if [ ! -f ~/google-cloud-sdk/install.sh ] && ! [ -x "$(command -v gcloud)" ]; then
    read -p "$(echo $Cyan'Google Cloud install script not found. Install? (y/n): '${Color_Off})" install_google_cloud
    if [ $install_google_cloud = "y" ] || [ $install_google_cloud = "Y" ]; then
        eval $google_cloud_install
        eval $google_cloud_extract
        eval $google_cloud_remove_tar_file
        if [ -x "$(command -v gcloud)" ]; then
            echo "" >> ~/.zshrc
            echo '# The next line updates PATH for the Google Cloud SDK.' >> ~/.zshrc
            echo "if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi">> ~/.zshrc
            echo "" >> ~/.zshrc
            echo '# The next line enables shell command completion for gcloud.' >> ~/.zshrc
            echo "if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi">> ~/.zshrc
        fi
    fi
else 
    echo "${Cyan}Found gcloud."
    if [ -x "$(command -v gcloud)" ]; then
        echo "" >> ~/.zshrc
        echo '# The next line updates PATH for the Google Cloud SDK.' >> ~/.zshrc
        echo "if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi">> ~/.zshrc
        echo "" >> ~/.zshrc
        echo '# The next line enables shell command completion for gcloud.' >> ~/.zshrc
        echo "if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi">> ~/.zshrc
    fi
fi

# ===== vim plug manager
# used for vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    eval $vim_plug_install
fi

# ===== INSTALLATIONS COMPLETE


echo ""
echo "${Green}Initialization complete.${Color_Off} Please run the following to finalize setup:"
if [ ! $SHELL = "/usr/bin/zsh" ]; then echo "${Yellow}>${Color_Off} chsh -s /usr/bin/zsh (may need to refresh terminal)"; fi
if [ -f ~/google-cloud-sdk/install.sh ] && [ ! -x "$(command -v gcloud)" ]; then 
    if [ ! -x "$(command -v gcloud)" ]; then echo "${Yellow}>${Color_Off} ~/google-cloud-sdk/install.sh"; fi
    echo "${Yellow}>${Color_Off} gcloud init (optional: will sign you into gcloud)"
fi
echo "${Yellow}>${Color_Off} source ~/.zshrc"
cd $origin

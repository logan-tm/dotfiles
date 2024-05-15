#!/bin/bash

# This was taken/modified by Stephan Raabe from the ML4W Dotfiles project.
# Link to his work: https://gitlab.com/stephan-raabe/dotfiles

version=$(cat .version/name)
export DOTFILES_INSTALL_LOCATION="/home/$USER/.dotfiles"
source .install/util/colors.sh
source .install/util/functions.sh
clear

# Set installation mode
mode="live"
if [ ! -z $1 ]; then
    mode="dev"
    echo "IMPORTANT: DEV MODE ACTIVATED. "
    echo "Existing dotfiles folder will not be modified."
    echo "Symbolic links will not be created."
fi
echo -e "${GREEN}"
cat <<"EOF"
______      _    __ _ _             _____          _        _ _ 
|  _  \    | |  / _(_) |           |_   _|        | |      | | |
| | | |___ | |_| |_ _| | ___  ___    | | _ __  ___| |_ __ _| | |
| | | / _ \| __|  _| | |/ _ \/ __|   | || '_ \/ __| __/ _` | | |
| |/ / (_) | |_| | | | |  __/\__ \  _| || | | \__ \ || (_| | | |
|___/ \___/ \__|_| |_|_|\___||___/  \___/_| |_|___/\__\__,_|_|_|
                                                                 
EOF
echo -e "${NONE}"

echo "Version: $version"
echo "original by Stephan Raabe 2024"
echo "edited and used here by Logan Michalicek 2024 (personal use)"
echo ""
if [ -d ~/.dotfiles ] ;then
    echo "A dotfiles installation has been detected."
    echo "This script will guide you through the update process of your dotfiles."
else
    echo "This script will guide you through the installation process of your dotfiles."
fi
echo ""
source .install/scripts/required.sh
source .install/scripts/confirm-start.sh
# source .install/scripts/yay.sh
# source .install/scripts/updatesystem.sh
# source .install/scripts/backup.sh
# source .install/scripts/preparation.sh
# source .install/scripts/installer.sh
# source .install/scripts/remove.sh
# source .install/scripts/general.sh
# source .install/scripts/packages/general-packages.sh
# source .install/scripts/install-packages.sh
# source .install/scripts/profile.sh
if [[ $profile == *"Hyprland"* ]]; then
    echo -e "${GREEN}"
    figlet "Hyprland"
    echo -e "${NONE}"
    source .packages/hyprland.sh
    # source .install/scripts/install-packages.sh
fi
if [[ $profile == *"Qtile"* ]]; then
    echo -e "${GREEN}"
    figlet "Qtile"
    echo -e "${NONE}"
    source .packages/qtile-packages.sh
    # source .install/scripts/install-packages.sh
fi
# source .install/scripts/wallpaper.sh
# source .install/scripts/displaymanager.sh
# source .install/scripts/issue.sh
# source .install/scripts/restore.sh
# source .install/scripts/neovim.sh
# source .install/scripts/keyboard.sh
# source .install/scripts/hook.sh
# source .install/scripts/vm.sh
# source .install/scripts/copy.sh
# source .install/scripts/init-pywal.sh
if [[ $profile == *"Hyprland"* ]]; then
    # source .install/scripts/hyprland-dotfiles.sh
fi
if [[ $profile == *"Qtile"* ]]; then
    # source .install/scripts/qtile-dotfiles.sh
fi
# source .install/scripts/settings.sh
# source .install/scripts/apps.sh
# source .install/scripts/gtk.sh
# source .install/scripts/bashrc.sh
# source .install/scripts/cleanup.sh
# source .install/scripts/diagnosis.sh
# source .install/scripts/reboot.sh
sleep 3

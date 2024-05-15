#!/bin/bash

# This was taken/modified by Stephan Raabe from the ML4W Dotfiles project.
# Link to his work: https://gitlab.com/stephan-raabe/dotfiles

version=$(cat .version/name)
source .install/includes/colors.sh
source .install/includes/library.sh
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
echo ""
if [ -d ~/.dotfiles ] ;then
    echo "A dotfiles installation has been detected."
    echo "This script will guide you through the update process of your dotfiles."
else
    echo "This script will guide you through the installation process of your dotfiles."
fi
echo ""
source .install/required.sh
source .install/confirm-start.sh
source .install/yay.sh
source .install/updatesystem.sh
source .install/backup.sh
source .install/preparation.sh
source .install/installer.sh
source .install/remove.sh
source .install/general.sh
source .install/packages/general-packages.sh
source .install/install-packages.sh
source .install/profile.sh
if [[ $profile == *"Hyprland"* ]]; then
    echo -e "${GREEN}"
    figlet "Hyprland"
    echo -e "${NONE}"
    source .install/packages/hyprland-packages.sh
    source .install/install-packages.sh
fi
if [[ $profile == *"Qtile"* ]]; then
    echo -e "${GREEN}"
    figlet "Qtile"
    echo -e "${NONE}"
    source .install/packages/qtile-packages.sh
    source .install/install-packages.sh
fi
source .install/wallpaper.sh
source .install/displaymanager.sh
source .install/issue.sh
source .install/restore.sh
source .install/neovim.sh
source .install/keyboard.sh
source .install/hook.sh
source .install/vm.sh
source .install/copy.sh
source .install/init-pywal.sh
if [[ $profile == *"Hyprland"* ]]; then
    source .install/hyprland-dotfiles.sh
fi
if [[ $profile == *"Qtile"* ]]; then
    source .install/qtile-dotfiles.sh
fi
source .install/settings.sh
source .install/apps.sh
source .install/gtk.sh
source .install/bashrc.sh
source .install/cleanup.sh
source .install/diagnosis.sh
source .install/reboot.sh
sleep 3

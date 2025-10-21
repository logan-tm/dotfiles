#!/bin/bash

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

source "$DOTFILES/util/print.sh"

pretty_print info "Updating system packages..."
sudo pacman -Syu --noconfirm

install_yay () {
    if yay --version >/dev/null 2>&1; then
        pretty_print skip "yay is already installed"
        return 0
    fi
    pretty_print info "Installing required dependencies: git and base-devel..."
    sudo pacman -S --needed --noconfirm git base-devel

    pretty_print info "Cloning the yay repository..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay

    pretty_print info "Navigating to the yay directory and building/installing..."
    cd /tmp/yay
    makepkg -si --noconfirm

    pretty_print info "Cleaning up..."
    rm -rf /tmp/yay

    pretty_print info "Testing installation..."
    # if yay --version >/dev/null 2>&1; then
    if yay --version; then
        pretty_print success "yay is configured correctly."
    else
        pretty_print fail "yay configuration test failed. Please check the installation."
        exit 1
    fi

    echo "yay installation complete."
}

install_yay

#!/usr/bin/bash

keys_conf="$( dirname -- "$( readlink -f -- "$0"; )"; )/keys.conf"
echo $keys_conf

# At the moment, doesn't work. 
# Using 'sudo' uses the root's keybindings.
# Not using 'sudo' gives permission denied.
dconf load /org/cinnamon/desktop/keybindings/ < $keys_conf

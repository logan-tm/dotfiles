#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/mango/scripts/rofi"

# Initial call: print list of scripts
if [ -z "$@" ]; then
    ls "$SCRIPT_DIR"
else
    # User selected a script, execute it
    "$SCRIPT_DIR/$@"
fi
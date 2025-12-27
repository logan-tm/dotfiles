#!/usr/bin/env bash

killall -9 waybar;
waybar -c "$HOME/.config/mango/waybar/config.jsonc" -s "$HOME/.config/mango/waybar/style.css" >/dev/null 2>&1 &
# waybar -c "$HOME/.config/mango/waybar/config.jsonc" -s "$HOME/.config/mango/waybar/style.css" &

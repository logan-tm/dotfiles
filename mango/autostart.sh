#!/usr/bin/env bash

swaync -c ~/.config/mango/swaync/config.jsonc -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &

bash "$HOME/.config/mango/scripts/launch-waybar.sh"
bash "$HOME/.config/mango/scripts/set-monitors.sh"

# # Get a list of all enabled outputs
# enabled_outputs=$(wlr-randr | grep -B 5 'Enabled: yes' | head -n 1 | awk '{print $1}')
# external_monitor_connected=false

# # Iterate through each enabled output to check if it's an external display
# for output in $enabled_outputs; do
#     if [[ "$output" != "eDP-1" ]]; then
#         external_monitor_connected=true
#         break # Exit loop once an external monitor is found
#     fi
# done

# if [ "$external_monitor_connected" = true ]; then
#     wlr-randr --output HDMI-A-1 --mode 3440x1440 --pos 0,0 --output eDP-1 --mode 2560x1600@60Hz --pos 3440,0 --scale 1.2 --output DP-3 --off
# else
#     echo "Only internal display is connected."
#     # Run a single-monitor configuration (disable USB-C monitors for now)
#     wlr-randr --output eDP-1 --mode 2560x1600@60Hz --pos 0,0 --scale 1.2 --output DP-3 --off
# fi


swaybg -i ~/Pictures/wall-cityscape.png >/dev/null 2>&1 &

# swaync >/dev/null 2>&1 &
sh ~/.config/mango/scripts/launch-waybar.sh

# Get a list of all enabled outputs
enabled_outputs=$(wlr-randr | grep -B 5 'Enabled: yes' | head -n 1 | awk '{print $1}')
external_monitor_connected=false

# Iterate through each enabled output to check if it's an external display
for output in $enabled_outputs; do
    if [[ "$output" != "eDP-1" ]]; then # Adjust "eDP-1" for your internal display name
        external_monitor_connected=true
        break # Exit loop once an external monitor is found
    fi
done

if [ "$external_monitor_connected" = true ]; then
    echo "External monitor is connected and enabled."
    # Run a multi-monitor configuration
    wlr-randr --output HDMI-A-1 --mode 3440x1440 --pos 0,0 --output eDP-1 --mode 2560x1600 --pos 3440,0 --scale 1.2
else
    echo "Only internal display is connected."
    # Run a single-monitor configuration
    wlr-randr --output eDP-1 --mode 2560x1600 --pos 0,0 --scale 1.2
fi


swaybg -i ~/Pictures/wall-cityscape.png >/dev/null 2>&1 &


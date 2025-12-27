#!/usr/bin/env bash

enabled_outputs=$(wlr-randr | awk '/Enabled: yes/ { print prev_lines[NR-5] } { prev_lines[NR] = $0 }' | awk '{ print $1 }')
disabled_outputs=$(wlr-randr | awk '/Enabled: no/ { print prev_lines[NR-5] } { prev_lines[NR] = $0 }' | awk '{ print $1 }')
all_outputs=("${enabled_outputs[@]}" "${disabled_outputs[@]}")

eo="${enabled_outputs[*]}"
do="${disabled_outputs[*]}"
ao="${all_outputs[*]}"

command=""

# Because of how wayland virtual monitors are at the moment, using multiple monitors is not preferred.
# Therefore, this script will identify the most desired output for my setup and set it properly.
# Monitor priority: HDMI-A-1, DP-3, eDP-1

# Is HDMI-A-1 plugged in?
if [[ "$ao" =~ "HDMI-A-1" ]]; then
	command+="wlr-randr --output HDMI-A-1 --mode 3440x1440 --pos 0,0"

	# Is it disabled? If so, enable it
	if [[ "$do" =~ "HDMI-A-1" ]]; then command+=" --on"; fi

	# Is another monitor enabled? If so, disable it
	if [[ "$eo" =~ "DP-3" ]]; then command+=" --output DP-3 --off"; fi
	if [[ "$eo" =~ "eDP-1" ]]; then command+=" --output eDP-1 --off"; fi

# Is the single cable USB-C plugged in?
elif [[ "$ao" =~ "DP-3" ]]; then
	command+="wlr-randr --output DP-3 --mode 3440x1440 --pos 0,0"

	# Is it disabled? If so, enable it
	if [[ "$do" =~ "DP-3" ]]; then command+=" --on"; fi

	# Is another monitor enabled? If so, disable it
	if [[ "$eo" =~ "HDMI-A-1" ]]; then command+=" --output HDMI-A-1 --off"; fi
	if [[ "$eo" =~ "eDP-1" ]]; then command+=" --output eDP-1 --off"; fi

else # using eDP-1 (laptop screen)
	command+="wlr-randr --output eDP-1 --mode 2560x1600@60Hz --pos 0,0 --scale 1.2"

	# Is it disabled? If so, enable it
	if [[ "$do" =~ "eDP-1" ]]; then command+=" --on"; fi

	# Is another monitor enabled? If so, disable it
	if [[ "$eo" =~ "HDMI-A-1" ]]; then command+=" --output HDMI-A-1 --off"; fi
	if [[ "$eo" =~ "DP-3" ]]; then command+=" --output DP-3 --off"; fi

fi

eval "$command"

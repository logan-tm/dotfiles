#!/usr/bin/env bash

selected_profile="$(cat .mozilla/firefox/profiles.ini | grep "Name=" | sed 's/^Name=//' | rofi -dmenu -p "Select Firefox profile")";

if [[ -n "$selected_profile" ]]; then
	firefox -P "$selected_profile" &
fi
#!/usr/bin/bash

source_if_exists () {
	if test -r "$1"; then
		# shellcheck source=/dev/null
		source "$1"
	else
		echo "Can't source $1"
	fi
}
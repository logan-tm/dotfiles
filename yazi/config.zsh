function run_yazi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Bind Ctrl+Y to run yazi
# bindkey '^Y' yazi

# https://www.reddit.com/r/zsh/comments/96asgu/how_to_bindkey_shell_commands_a_quick_guide/

function zle_yazi {
  zle_eval run_yazi
}

zle -N zle_yazi;
bindkey '^Y' zle_yazi;
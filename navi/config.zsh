# Bind Ctrl+N to run navi
# bindkey '^N' navi

# https://www.reddit.com/r/zsh/comments/96asgu/how_to_bindkey_shell_commands_a_quick_guide/

function zle_navi {
  zle_eval navi
}

zle -N zle_navi;
bindkey '^N' zle_navi;

function zle_ls {
  zle_eval ls --color=auto
}

zle -N zle_ls; bindkey "^L" zle_ls
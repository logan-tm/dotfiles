
# tmux commands
# add vertical pane:    C-a, \
# add horizontal pane:  C-a, -
# switch between panes: C-a, o
# close a pane:         C-a, x

alias ls='ls --color=auto -l'
alias tls='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias td='tmux detach'
alias tk='tmux kill-session'
alias tks='tmux kill-session -t'
alias tka='pkill -f tmux'

alias nvmg='nvm install lts/gallium && nvm use lts/gallium'

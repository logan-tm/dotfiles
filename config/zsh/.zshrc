alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

eval "$(starship init zsh)"

source ~/.antigen.zsh
antigen init ~/.config/.antigenrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH=~/.console-ninja/.bin:$PATH
export QT_QPA_PLATFORM="wayland;xcb"

fastfetch -l small
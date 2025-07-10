# alias param_example='() {echo ${1:="default"} $@[2,-1]}'
alias update="sudo apt-get update --yes && sudo apt-get upgrade --yes"
alias -g python="python3"
alias mkdir="mkdir -pv"

# function cursor() {
#   (nohup /home/lm/Applications/Cursor.AppImage "$@" > /dev/null 2>&1 &)
# }

alias reload="source ~/.zshrc"
alias dots="code ~/.dotfiles"
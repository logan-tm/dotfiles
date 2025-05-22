alias l="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -1"
alias lll="eza --icons --group-directories-first -l"
# tree with default level
alias lt='eza --icons --group-directories-first -1 --tree --git-ignore --level 2' 
# tree with level passed in as first arg
alias ltl='() { eza --icons --group-directories-first -1 --tree --git-ignore --level ${1:=2} $@[2,-1] }' 
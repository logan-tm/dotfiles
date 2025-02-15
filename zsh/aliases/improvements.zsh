# Aliases that enhance basic features. Typically, this includes custom packages.
# All aliases in this file will be separated by their package requirements.

###################################
# EZA
# An improved ls experience.
###################################

alias l="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -1"
alias lll="eza --icons --group-directories-first -l"
# tree with default level
alias lt='eza --icons --group-directories-first -1 --tree --git-ignore --level 2' 
# tree with level passed in as first arg
alias ltl='() { eza --icons --group-directories-first -1 --tree --git-ignore --level ${1:=2} $@[2,-1] }' 

###################################
# FZF
# Aliases relating to fuzzy finding.
###################################

# Fzf my command history, then place result in the command line
# alias fzh="print -z \$(history | sed -re 's/ *[0-9]* *//' | fzf --tac --no-sort)"
# With fzf installed, use CTRL + r for this functionality


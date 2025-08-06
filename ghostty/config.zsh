# https://github.com/ghostty-org/ghostty/discussions/4862
if [[ "$TERM_PROGRAM" == 'ghostty' ]]; then
    # bindkey '\e[1;3A' beginning-of-line # alt + up
    # bindkey '\e[1;3B' end-of-line # alt + down
    # bindkey '\e[3;3~' kill-word # alt + delete


    # bindkey "^[[1;5D"  backward-word         # CTRL+left
    # bindkey "^[[1;5C"  forward-word          # CTRL+right 
    # bindkey "^[[3;5~"  kill-word             # CTRL+delete
    # bindkey "^[[1;7D"  beginning-of-line     # CTRL+ALT+left (Ghostty)
    # bindkey "^[[1;7C"  end-of-line           # CTRL+ALT+right (Ghostty)
    # bindkey "^[[3;2~"  kill-whole-line       # SHIFT+delete
fi
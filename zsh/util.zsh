function zle_eval {
  echo -en "\e[2K\r"
  eval "$@"
  zle redisplay
}
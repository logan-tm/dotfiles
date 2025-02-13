info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

# info_success () {
#   printf "\033[00;32m\U0001F5F8\033[0m\n"

#   # Other check mark options
#   # printf "\033[00;32m\U0002714\033[0m\n"
#   # printf "\033[00;32m\U0002713\033[0m\n"
# }

# info_fail () {
#   printf "\033[0;31m\U00010102\033[0m\n"
# }

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

skip () {
  printf "\r\033[2K  [\033[0;33mSKIP\033[0m] $1\n"
}


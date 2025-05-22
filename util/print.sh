#!/usr/bin/bash

clear_last () {
    printf '\033[1A\033[K'
}

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

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

debug () {
  printf "\r\033[2K  [\033[0;35mDBUG\033[0m] $1\n"
}
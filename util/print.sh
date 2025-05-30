#!/usr/bin/bash

pretty_print () {
  # check if the first argument is info, user, success, fail, skip, or debug
  case $1 in
    info)
      printf "\r  [ \033[00;34m..\033[0m ] $2\n"
      ;;
    user)
      printf "\r  [ \033[0;33m??\033[0m ] $2\n"
      ;;
    success)
      printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $2\n"
      ;;
    fail)
      printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $2\n"
      ;;
    skip)
      printf "\r\033[2K  [\033[0;33mSKIP\033[0m] $2\n"
      ;;
    debug)
      printf "\r\033[2K  [\033[0;35mDBUG\033[0m] $2\n"
      ;;
    clear_last)
      printf '\033[1A\033[K'  # Clear the last line
      ;;
    space)
      printf "\r    ||\n"  # Print a new line
      ;;
    space_hr)
      printf "\r    ||   ___________________________________\n    ||\n"  # Print two new lines with a horizontal line in between
      ;;
    help)
      printf "Usage: pretty_print [info|user|success|fail|skip|debug|clear_last|space|space_hr]\n"
      printf "Prints a message with a specific format.\n\n"
      printf "Options:\n"
      printf "  info       Print an informational message\n"
      printf "  user       Print a user prompt message\n"
      printf "  success    Print a success message\n"
      printf "  fail       Print a failure message\n"
      printf "  skip       Print a skip message\n"
      printf "  debug      Print a debug message\n"
      printf "  clear_last Clear the last printed line\n"
      printf "  space      Print a space line\n"
      printf "  space_hr   Print a horizontal line with spaces\n"
      exit 0
      ;;
    *)
      printf "Unknown print type: $1"
      exit 1
      ;;
  esac
}
# Takes all the alias files in this directory and sources them.
# Assumes that every .zsh file in this directory is meant to be sourced.

thisdir="${funcsourcetrace[1]%/*}"
thisfile="${funcsourcetrace[1]%:0}"

# echo "DIR:  $thisdir"
# echo "FILE: $thisfile"

for file in "$thisdir"/*.zsh; do
  if [[ $file != $thisfile ]]; then
    # echo "SUBFILE: $file"
    source $file
  fi  
done
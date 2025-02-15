#!/usr/bin/env bash
# https://github.com/andrew8088/dotfiles/blob/main/install/bootstrap.sh
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

source "$DOTFILES/install/util.sh"

link_file () {
  local src=$1 dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      # ignoring exit 1 from readlink in case where file already exists
      # shellcheck disable=SC2155
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action  < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "Removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "Moved $dst to ${dst}.backup"
    fi

    # if [ "$skip" == "true" ]
    # then
    #   skip "Skipped $src"
    # fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "Linked $1 to $2"
  fi
}


prop () {
   PROP_KEY=$1
   PROP_FILE=$2
   PROP_VALUE=$(eval echo "$(cat $PROP_FILE | grep "$PROP_KEY" | cut -d'=' -f2)")
   echo $PROP_VALUE
}

install_dotfiles () {
  info 'Checking dotfiles...'

  local overwrite_all=false backup_all=false skip_all=false

  find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*' | while read linkfile; do
    for line in $(cat "$linkfile"); do
      local src dst dir
      src=$(eval echo "$line" | cut -d '=' -f 1)
      dst=$(eval echo "$line" | cut -d '=' -f 2)
      dir=$(dirname $dst)

      mkdir -p "$dir"
      link_file "$src" "$dst"
    done
  done
}

create_env_file () {
  info "Checking for .env.sh file..."
    if test -f "$HOME/.env.sh"; then
        skip "Env file already exists ($HOME/.env.sh)"
    else
        echo "export DOTFILES=$DOTFILES" > $HOME/.env.sh
        success 'Created ~/.env.sh'
    fi
}

setup_apt_packages() {
  # Install tools
  info "Checking apt packages..."
  local total_count=0
  local installed_count=0

  # TODO: If no deps file, skip this step
  find "$DOTFILES/install" -name 'deps-apt.txt' | while read depsfile; do
    for package in $(cat "$depsfile"); do
      if ! dpkg --status $package > /dev/null 2>&1 ; then
          sudo apt install -y $package
          success "$package installed"
      else
          skip "Already installed $package"
      fi
    done
  done


  # success "Packages installed"
}

setup_antigen() {
  ANTIGEN_ZSH="$DOTFILES/antigen/antigen.zsh"

  if [ ! -f "$ANTIGEN_ZSH" ]; then
    info "Setting up antigen..."
    curl -L git.io/antigen > "$ANTIGEN_ZSH"
    success "Installed antigen"
  else
    skip "Antigen found"
  fi
}

setup_vim () {
  info 'Customizing vim...'

  # COLORS_DIR=~/.vim/colors/
  # THEME=$DOTFILES/vim/themes/spring-night.vim

  # mkdir -p $COLORS_DIR
  # cp $THEME $COLORS_DIR

  # Commented out the above in favor of sym link for theme

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null
  
  vim +PlugInstall +PlugUpdate +qall

  success 'Vim customization complete'
}

install_cargo() {
  info "Checking for rust..."
  if [ -z "$(which rustc)" ]; then
    info "Not found. Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    success "Installed rust"
  fi
}

# install_cargo_packages() {

# }

setup_aws_cli() {
    info "Installing AWS CLI"
    cd /tmp
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &> /dev/null
    unzip -qq -o awscliv2.zip
    sudo ./aws/install --update
    #rm -rf /tmp/awscliv2.zip /tmp/aws
    pip3 install -U cfn-lint
}

install_dotfiles
create_env_file
setup_apt_packages
# setup_vim
setup_antigen
install_cargo
# install_cargo_packages
# setup_aws_cli

echo ''
echo ''
success 'All installed!'
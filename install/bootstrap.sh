#!/usr/bin/env bash
# https://github.com/andrew8088/dotfiles/blob/main/install/bootstrap.sh
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

source "$DOTFILES/util/print.sh"

# UTILS ==========================

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

        pretty_print user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
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
      pretty_print success "Removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      pretty_print success "Moved $dst to ${dst}.backup"
    fi

    # if [ "$skip" == "true" ]
    # then
    #   pretty_print skip "Skipped $src"
    # fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    pretty_print success "Linked $1 to $2"
  fi
}

prop () {
   PROP_KEY=$1
   PROP_FILE=$2
   PROP_VALUE=$(eval echo "$(cat $PROP_FILE | grep "$PROP_KEY" | cut -d'=' -f2)")
   echo $PROP_VALUE
}

# LINK FILES AND CREATE ENV FILE

install_dotfiles () {
  # pretty_print info 'Checking dotfiles...'

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
  pretty_print success "Linked dotfiles"
}

create_env_file () {
    if test -f "$HOME/.env.sh"; then
        pretty_print skip "Env file exists ($HOME/.env.sh)"
    else
        echo "export DOTFILES=$DOTFILES" > $HOME/.env.sh
        pretty_print success 'Created ~/.env.sh'
    fi
}

# CHECK FOR AND INSTALL PACKAGE INSTALLERS

install_cargo() {
  if [ -z "$(which rustc)" ]; then
    pretty_print info "Rust/Cargo not found. Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    pretty_print clear_last && pretty_print success "Installed rust"
  else
    pretty_print skip "Rust/Cargo found"
  fi
}

install_brew() {
  if [ ! -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    pretty_print info "Brew not found. Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    pretty_print clear_last && pretty_print success "Installed brew"
  else
    pretty_print skip "Brew found"
  fi
}

# INSTALL PACKAGES

install_apt_packages() {
  # Install tools
  # pretty_print info "Checking apt packages..."
  local total_count=0
  local installed_count=0

  # TODO: If no deps file, skip this step
  find "$DOTFILES/install" -name 'deps-apt.txt' | while read depsfile; do
    for package in $(cat "$depsfile"); do
      pretty_print info "Checking $package..."
      if ! dpkg --status $package > /dev/null 2>&1 ; then
          sudo apt install -y $package
          pretty_print clear_last && pretty_print success "$package installed"
      else
          pretty_print clear_last
      fi
    done
  done


  pretty_print success "Apt packages checked/installed"
}

install_brew_packages() {
  # Install tools
  # pretty_print info "Checking brew packages..."
  local total_count=0
  local installed_count=0

  # TODO: If no deps file, skip this step
  find "$DOTFILES/install" -name 'deps-brew.txt' | while read depsfile; do
    installed_brew_packages=$(/home/linuxbrew/.linuxbrew/bin/brew list)
    for package in $(cat "$depsfile"); do
      pretty_print info "Checking $package..."
      # check if package is included in the "already installed" list
      if [[ $installed_brew_packages = *"$package"* ]]; then
        pretty_print clear_last
      else
        pretty_print info "Installing $package..."
        /home/linuxbrew/.linuxbrew/bin/brew install $package > /dev/null 2>&1
        pretty_print clear_last && pretty_print success "$package installed"
      fi
      # if /home/linuxbrew/.linuxbrew/bin/brew pretty_print info $package | grep "Not installed" > /dev/null 2>&1; then
      #     pretty_print info "Installing $package..."
      #     /home/linuxbrew/.linuxbrew/bin/brew install $package
      #     pretty_print success "$package installed"
      # else
      #     pretty_print skip "Already installed $package"
      # fi
    done
  done

  pretty_print success "Brew packages checked/installed"
}

install_cargo_packages() {
  # Install tools
  # pretty_print info "Checking cargo packages..."
  local total_count=0
  local installed_count=0

  # TODO: If no deps file, skip this step
  find "$DOTFILES/install" -name 'deps-cargo.txt' | while read depsfile; do
    for package in $(cat "$depsfile"); do
      pretty_print info "Checking $package..."
      if ! cargo install --list | grep "$package v" > /dev/null 2>&1 ; then
          cargo install $package
          pretty_print clear_last && pretty_print success "$package installed"
      else
          pretty_print clear_last
      fi
    done
  done

  pretty_print success "Cargo packages checked/installed"
}

setup_vim () {
  pretty_print info 'Customizing vim...'

  # COLORS_DIR=~/.vim/colors/
  # THEME=$DOTFILES/vim/themes/spring-night.vim

  # mkdir -p $COLORS_DIR
  # cp $THEME $COLORS_DIR

  # Commented out the above in favor of sym link for theme

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null
  
  vim +PlugInstall +PlugUpdate +qall

  pretty_print success 'Vim customization complete'
}

install_ghostty () {
  if [ -z "$(which ghostty)" ]; then
    pretty_print info "Ghostty not found. Installing ghostty..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
    pretty_print success "Installed ghostty"
  else
    pretty_print skip "Ghostty found"
  fi
  
}

install_nvm () {
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    pretty_print info "NVM needs to be installed"
    /bin/bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)"
    pretty_print success "Installed NVM"
  else
    pretty_print skip "NVM found"
  fi
}

install_uv () {
  if [ -z "$(which uv)" ]; then
    pretty_print info "UV not found. Installing UV..."
    /bin/bash -c "$(curl -fsSL https://astral.sh/uv/install.sh)"
    pretty_print success "Installed UV"
  else
    pretty_print skip "UV found"
  fi
}

install_dotfiles
create_env_file
# setup_vim
install_cargo
install_brew

install_apt_packages
install_brew_packages
install_cargo_packages
# setup_aws_cli
install_ghostty
install_nvm
install_uv

pretty_print space_hr
pretty_print success 'All installed!'
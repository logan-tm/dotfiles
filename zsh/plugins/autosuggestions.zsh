DIR="${ZSH_CUSTOM:-$HOME/.config/zsh}/plugins/zsh-autosuggestions"

if [[ ! -d "$DIR" ]]; then
  echo "Cloning to $DIR!"
  # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions $DIR
else
  echo "zsh-autosuggestions already installed"
fi

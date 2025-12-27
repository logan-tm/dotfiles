DIR="${ZSH_CUSTOM:-$HOME/.config/zsh}/plugins/fast-syntax-highlighting"

if [[ ! -d "$DIR" ]]; then
  # git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $DIR
else
  echo "fast-syntax-highlighting already installed"
fi
# ---- FZF -----
# https://github.com/josean-dev/dev-environment-files/blob/main/.zshrc#L40

# Use 'CTRL + r' to search through command history
# Use 'CTRL + t' to bring up a fzf list of the current directory and its contents
# Use '**' then TAB at the end of select commands for further functionality as described below
# 	When using 'cd', show a fzf list of only directories at CWD
# 	When using 'ssh', show a fzf list of recent connections
# 	When killing processes with 'kill -9', shows processes
# 	There's probably more
# Often times, you can use TAB again to select multiple items, and CTRL + TAB to deselect items
# You can still use ** with other commands, but they will include files as well (example: 'nvim **')

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"

# --- setup fzf theme ---
# fg="#CBE0F0"
# bg="#011628"
# bg_highlight="#143652"
# purple="#B388FF"
# blue="#06BCE4"
# cyan="#2CF9ED"

# export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_DEFAULT_OPTS="-e --height=50% --tmux=50% --layout=reverse --info=inline --border --margin=1 --padding=1"

# -- Use fd instead of fzf --

# export USING_RIPGREP='rg --files --hidden --glob "!.git"'
# export FZF_DEFAULT_COMMAND="$USING_RIPGREP"
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git --exclude __pycache__"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

_fzf_complete_git() {
  _fzf_complete -- "$@" < <(
    git --help -a | grep -E '^\s+' | awk '{print $1}'
  )
}

_fzf_complete_aws() {
  _fzf_complete -- "$@" < <(
    aws help | tr -d '\b' | sed -n '/SSEERRVVIICCEESS/,/SSEEEE/p' | sed -r '/^\s*$/d' | sed '1d;$d' | awk '{print $2}'
  )
}

# source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"          "$@" ;;
    git)          fzf --preview "eval 'tldr $command {}'"   "$@" ;;
    aws)          fzf --preview-window 75%,wrap --preview "eval 'tldr $command {}'"   "$@" ;;
    ssh)          fzf --preview 'dig {}'                    "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# dotfiles
A personal repository to keep track of my custom dotfile configurations. This will be updated over time as I customize my linux command line experience.

## Installation
1. Pull this repo (example: into a `github/` folder).
2. If necessary, set the init script to be executable (`chmod -x github/dotfiles/init.sh`).
3. Install starship with this command: `curl -sS https://starship.rs/install.sh | sh` and follow the prompts.
4. If you haven't already, install a Nerd Font. If using WSL, this font will live in `C:\Windows\Fonts` and can be selected within the Windows Terminal settings.
5. Run the init script (`sh github/dotfiles/init.sh`).
NOTE: Flags are available for optional installs, like `-n` to install nvm. `-a` will install all optional items.
5. Source the local `.zshrc` file (`source ~/.zshrc`).

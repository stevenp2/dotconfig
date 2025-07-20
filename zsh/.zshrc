source "$HOME/dotconfig/setup-utils.sh"
if is_linux; then
  source "$HOME/dotconfig/zsh/linux.sh"
elif is_mac; then
  source "$HOME/dotconfig/zsh/mac.sh"
else
  echo "Failed to $action: unsupported OS"
fi

### PATH Additions ###
function pathadd() {
  # if exists and not already in path
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1${PATH:+":${PATH}"}"
  fi
}
pathadd "$HOME/.bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/.cargo/env"
pathadd "$HOME/go/bin"
pathadd "$HOME/bin/path"

# zsh extension
eval "$(starship init zsh)"

# zsh location
export ZSH="$HOME/.oh-my-zsh"
# editor
export EDITOR="nvim"

plugins=(
    git
    gitignore
    # starship
    colored-man-pages
    sudo
    ubuntu
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)
fpath+=~/.oh-my-zsh/custom/plugins/zsh-completions/src

# ZSH_THEME="jonathan"
source $ZSH/oh-my-zsh.sh

### aliases

# colorise output
alias grep='grep --color=auto'
alias diff='diff --color'

# lazy
alias v='nvim'
alias g='git status'

# browsers
alias brave='./opt/brave.com/brave &'
alias firefox='firefox &'

# neofetch
alias neofetch='neofetch --ascii ~/.config/neofetch/monkey.txt'

# lazygit
alias lg='lazygit'

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -e /home/g/.nix-profile/etc/profile.d/nix.sh ]; then . /home/g/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

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
pathadd "$HOME/go/bin"
pathadd "$HOME/bin/path"
pathadd "$HOME/.cargo/bin:"

#zsh extension
eval "$(starship init zsh)"

# zsh location
export ZSH="$HOME/.oh-my-zsh"

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

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
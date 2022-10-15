# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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
pathadd "$HOME/go/bin"
pathadd "$HOME/bin/path"
pathadd "$HOME/.cargo/bin:"

# zsh extension
eval "$(starship init zsh)"

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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


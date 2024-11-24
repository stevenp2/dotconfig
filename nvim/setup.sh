#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

# Install Neovim
action="install Neovim"
if ! check_dependency "nvim" && confirm "$action"; then
  if is_linux; then
    sudo apt install neovim
  elif is_mac; then
    brew install neovim
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="install Neovim Python support"
if ! $OS_PYTHON -c "import neovim" 2> /dev/null && confirm "$action"; then
  uv $OS_PIP install pynvim
fi

action="link config"
if confirm "$action"; then
    link_config $HOME/dotconfig/nvim $HOME/.config/nvim
fi

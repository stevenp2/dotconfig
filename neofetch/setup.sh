#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install neofetch"
if ! check_dependency "neofetch" && confirm "$action"; then
  if is_linux; then
    sudo apt install neofetch
  elif is_mac; then
    brew install neofetch
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link neofetch"
if confirm "$action"; then
  if is_linux || is_mac; then
    link_config "$HOME/dotconfig/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"
    link_config "$HOME/dotconfig/neofetch/monkey.txt" "$HOME/.config/neofetch/monkey.txt"
  else
    echo "invalid OSTYPE $OSTYPE for zsh setup"
  fi
fi


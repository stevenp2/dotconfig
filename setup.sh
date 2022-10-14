#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

mkdir -p ~/.config

setup_app() {
  app=$1
  action="setup $app"
  if confirm "$action"; then
    setup_script="$HOME/dotconfig/$app/setup.sh"
    chmod +x $setup_script
    $setup_script
  fi
}

setup_add nvim
setup_add lazygit
setup_add alacritty

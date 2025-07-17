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

setup_app zsh
setup_app nvim
setup_app lazygit
setup_app alacritty
setup_app bottom
setup_app neofetch

if is_linux; then
  setup_app bar/polybar
elif is_mac; then
  setup_app bar/sketchybar
fi



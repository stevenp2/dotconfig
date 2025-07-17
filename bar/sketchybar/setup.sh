#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install sketchybar"
if confirm "$action"; then
  brew tap FelixKratz/formulae && \
  brew install sketchybar && \
  brew services start sketchybar
fi

action="link config"
if confirm "$action"; then
  link_config "$HOME/dotconfig/bar/sketchybar" "$HOME/.config/sketchybar"
fi

action="give execution permission to plugins"
if confirm "$action"; then
    chmod +x "$HOME/dotconfig/bar/sketchybar/plugins/"*
    chmod +x "$HOME/dotconfig/bar/sketchybar/items/"*
fi

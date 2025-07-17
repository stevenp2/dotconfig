#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

NERDFONT="Hack"

action="install $NERDFONT Nerd font"
if confirm "$action"; then
  if is_linux; then
    wget --no-verbose https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$NERDFONT.zip
    unzip $NERDFONT.zip -d $NERDFONT-NF 2> /dev/null
    rm $NERDFONT.zip
    cp -r ./$NERDFONT-NF/$NERDFONT\ * ~/.fonts
    rm -r $NERDFONT-NF
    fc-cache -fv 
  elif is_mac; then
    brew install font-hack-nerd-font
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link config"
if confirm "$action"; then
  if is_linux; then
    link_config $HOME/dotconfig/alacritty/alacritty-linux.toml $HOME/.config/alacritty/alacritty.toml
  elif is_mac; then
    link_config $HOME/dotconfig/alacritty/alacritty-mac.toml $HOME/.config/alacritty/alacritty.toml
  else
    echo "invalid OSTYPE $OSTYPE for alacritty setup"
  fi
fi

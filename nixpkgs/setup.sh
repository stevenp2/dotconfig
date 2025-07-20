#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install nix"
if ! check_dependency nix; then
  curl -L https://nixos.org/nix/install | sh
  sh -c "nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && nix-channel update"
fi

action="link config"
if confirm "$action"; then
    link_config "$HOME/dotconfig/nixpkgs" "$HOME/.config/nixpkgs"
fi

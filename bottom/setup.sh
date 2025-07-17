#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="install bottom"
if ! check_dependency btm; then
  if is_linux && confirm "$action"; then
    latest=$(get_latest_release "ClementTsang/bottom")
    curl -LO https://github.com/ClementTsang/bottom/releases/download/$latest/bottom_${latest}_amd64.deb
    sudo dpkg -i bottom_${latest}_amd64.deb
    rm bottom_${latest}_amd64.deb
  elif is_mac && confirm "$action"; then
    brew install bottom
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

action="link bottom config"
if confirm "$action"; then
  if is_linux; then
    link_config "$HOME/dotconfig/bottom/bottom.toml" "$HOME/.config/bottom/bottom.toml"
  elif is_mac; then
    mkdir -p  ${HOME}/.config/bottom
    link_config "$HOME/dotconfig/bottom/bottom.toml" "$HOME/.config/bottom/bottom.toml" true
  else
    echo "Failed to $action: unsupported OS"
  fi
fi

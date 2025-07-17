#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="link config"
if confirm "$action"; then
    link_config "$HOME/dotconfig/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

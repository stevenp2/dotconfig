#!/bin/bash
source "$HOME/dotconfig/setup-utils.sh"

action="link config"
if confirm "$action"; then
    link_config "$HOME/dotconfig/rofi/config.rasi" "$HOME/.config/config.rasi"
fi


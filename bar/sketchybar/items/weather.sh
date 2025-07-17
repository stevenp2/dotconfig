#!/bin/bash

moon=(
  # background.color=0x667dc4e4
  background.color=$TRANSPARENT
  background.padding_right=-7
  icon.color=$YELLOW
  icon.font="$FONT:Bold:20.0"
  label.drawing=off
  script="$PLUGIN_DIR/moon.sh"
)

weather=(
  icon.color=0xfff5bde6
  icon.font="$FONT:Bold:12.0"
  label.font="$FONT:Bold:12.0"
  update_freq=1800
  script="$PLUGIN_DIR/weather.sh"
)
sketchybar --add item weather q \
           --set weather "${weather[@]}" \
           --subscribe weather system_woke

sketchybar	--add item moon q \
            --set moon "${moon[@]}" \
            --subscribe moon mouse.clicked


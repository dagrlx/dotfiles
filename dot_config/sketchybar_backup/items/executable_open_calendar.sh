#!/bin/bash

ocalendar=(
  icon=􀒎
  #icon.padding_right=10
  label=?
  padding_right=10
  label.drawing=off
  click_script="$PLUGIN_DIR/open_calendar.sh"
)

sketchybar --add item ocalendar center       \
           --set ocalendar "${ocalendar[@]}" 


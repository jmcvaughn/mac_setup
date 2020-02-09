#!/bin/sh

ratio=$(($(yabai -m query --displays --display | jq -r '.frame | del(.x, .y) | join("/")')))

case $ratio in
	1) yabai -m window --grid 10:10:1:1:8:7 ;;  # Normal aspect ratios, e.g. 16:10
	2) yabai -m window --grid 10:10:3:1:4:6 ;;  # Ultrawide, e.g. 21:9
esac

# vim: set filetype=bash:

#!/usr/bin/env sh

cd "$(dirname "$0")"  # Change to script's directory

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

# Symlink Firefox profile directory for Java Web Start (used only for BMC
# console redirection)
gmkdir "$HOME/.mozilla/" 2> /dev/null
gln -s "$HOME/Library/Application Support/Firefox/" "$HOME/.mozilla/firefox" 2> /dev/null

# vim: set filetype=bash:

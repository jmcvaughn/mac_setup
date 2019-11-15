#!/usr/bin/env sh

cd "$(dirname "$0")"  # Change to script's directory

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

# Symlink Firefox profile directory for Java Web Start (used only for BMC
# console redirection)
mkdir "$HOME/.mozilla/" 2> /dev/null
ln -s "$HOME/Library/Application Support/Firefox/" "$HOME/.mozilla/firefox" 2> /dev/null

# vim: set filetype=bash:

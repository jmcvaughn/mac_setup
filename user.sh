#!/usr/bin/env sh

cd "$(dirname "$0")"  # Change to script's directory

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

# vim: set filetype=bash:

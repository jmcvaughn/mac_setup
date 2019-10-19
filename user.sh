#!/usr/bin/env sh

cd "$(dirname "$0")"  # Change to script's directory

# Change user default shell to Homebrew Zsh
test "$SHELL" != '/usr/local/bin/zsh' && chsh -s /usr/local/bin/zsh

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

# vim: set filetype=bash:

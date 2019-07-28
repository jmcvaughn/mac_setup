#!/bin/bash

cd "$(dirname $0)"  # Change to script's directory

# Change user default shell to Homebrew Zsh
[[ $SHELL != '/usr/local/bin/zsh' ]] && chsh -s /usr/local/bin/zsh

# Copy dotfiles
gcp -rL dotfiles/. "$HOME"


#!/usr/bin/env sh

cd "$(dirname "$0")"  # Change to script's directory

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

# Fetch iTerm2 Zsh shell integration script
curl -L https://iterm2.com/shell_integration/zsh -o "$HOME"/.iterm2_shell_integration.zsh

# Symlink Firefox profile directory for Java Web Start (used only for BMC
# console redirection)
gmkdir "$HOME/.mozilla/" 2> /dev/null
gln -s "$HOME/Library/Application Support/Firefox/" "$HOME/.mozilla/firefox" 2> /dev/null

# vim: set filetype=bash:

#!/bin/sh

cd "$(dirname "$0")"  # Change to script's directory

# Copy dotfiles
gcp -r --dereference dotfiles/. "$HOME"

gmkdir "$HOME"/vagrant/ > /dev/null 2>&1
gln -s "$HOME"/git/qmk_firmware/ "$HOME"/qmk_firmware > /dev/null 2>&1

# Fetch iTerm2 Zsh shell integration script
curl -L https://iterm2.com/shell_integration/zsh -o "$HOME"/.iterm2_shell_integration.zsh

# Symlink Firefox profile directory for Java Web Start (used only for BMC
# console redirection)
gmkdir "$HOME"/.mozilla/ > /dev/null 2>&1
gln -s "$HOME/Library/Application Support/Firefox/" "$HOME"/.mozilla/firefox > /dev/null 2>&1

# vim: set filetype=bash:

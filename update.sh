#!/bin/bash

# Update Homebrew packages
brew update
brew upgrade
brew cask upgrade --greedy

# Update Launchbar Actions
cd ~/Library/Application\ Support/LaunchBar/Actions/
for action in *; do
  git -C "$action" pull
done

# Update Microsoft Office
/Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate --install


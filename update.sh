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


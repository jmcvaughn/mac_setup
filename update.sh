#!/usr/bin/env sh

linn_konfig_outdated() {
  konfig_updates_url='https://linn-ui-buildartifacts-prod.s3-eu-west-1.amazonaws.com/applications/konfig/updates.json'
  konfig_installed=$(mdls /Applications/Konfig.app/ | awk -F '= ' '/kMDItemVersion/ {gsub(/"/, ""); print $2}')
  konfig_latest=$(curl -s "$konfig_updates_url" | jq -r '[.releases[] | select(.quality == "stable") | select(.platform == "macosx")] | .[0] | .version')

  # If installed version is same or newer than latest stable, don't attempt to
  # update. Allows for temporary, manual beta installation outside of Homebrew
  # while automatically reverting to newer stable releases when available.
  if [ "$(printf "$konfig_installed\n$konfig_latest" | gsort --version-sort | gtail --lines 1)" = "$konfig_installed" ]; then
    return 1
  fi
}

# Fetch newest version of Homebrew and formulae
brew update

# Update Homebrew packages
brew upgrade
brew cask upgrade

# Update "greedy" packages individually
linn_konfig_outdated && brew cask upgrade --greedy linn-konfig

# Update Launchbar Actions
cd "$HOME/Library/Application Support/LaunchBar/Actions/"
for action in *; do
  git -C "$action" pull
done

# Update Microsoft Office
'/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate' --install

# vim: set filetype=bash foldmethod=syntax:

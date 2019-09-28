#!/usr/bin/env zsh

linn_konfig_outdated() {
  konfig_installed="$(mdls /Applications/Konfig.app \
    | awk -F '= ' '/kMDItemVersion/ { gsub(/"/, ""); print $2 }')"
  konfig_latest="$(curl -s https://linn-ui-buildartifacts-prod.s3-eu-west-1.amazonaws.com/applications/konfig/updates.json \
    | jq -r '[.releases[] | select(.quality == "stable") | select(.platform == "macosx")] | .[0] | .version')"

  # If installed version is same or newer than latest stable, don't attempt to
  # upgrade. Allows for temporary, manual beta installation outside of Homebrew
  # while automatically reverting to newer stable releases when available.
  [[ $(echo -e "$konfig_installed\n$konfig_latest" | gsort --version-sort \
    | gtail --lines 1) == $konfig_installed ]] && return 1
}

# Update Homebrew packages
brew update
brew upgrade
brew cask upgrade

# Upgrade "greedy" packages individually
linn_konfig_outdated && brew cask upgrade --greedy linn-konfig

# Update Launchbar Actions
cd ~/Library/Application\ Support/LaunchBar/Actions/
for action in *; do
  git -C "$action" pull
done

# Update Microsoft Office
/Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate --install


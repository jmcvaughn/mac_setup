#!/usr/bin/env zsh

linn_konfig_outdated() {
  konfig_installed="$(mdls /Applications/Konfig.app \
    | awk -F '= ' '/kMDItemVersion/ { gsub(/"/, ""); print $2 }')"
  konfig_latest="$(curl -s https://linn-ui-buildartifacts-prod.s3-eu-west-1.amazonaws.com/applications/konfig/updates.json \
    | jq -r '[.releases[] | select(.quality == "stable") | select(.platform == "macosx")] | .[0] | .version')"

  # If installed version is same or newer than latest stable, don't attempt to
  # update. Allows for temporary, manual beta installation outside of Homebrew
  # while automatically reverting to newer stable releases when available.
  [[ $(echo -e "$konfig_installed\n$konfig_latest" | gsort --version-sort \
    | gtail --lines 1) == $konfig_installed ]] && return 1
}

# Fetch newest version of Homebrew and formulae
brew update

# Get LibreOffice Language Pack version after update and check if was (is)
# outdated. Will also be "not outdated" if package is not installed.
lolang_newvers="$(brew cask outdated libreoffice-language-pack \
  | gawk 'BEGIN {rc=1} {rc=0; print $4} END {exit rc}')"
lolang_wasoutdated=$?

# Update Homebrew packages
brew upgrade
brew cask upgrade

# If LibreOffice Language Pack was outdated (now updated in previous step), run
# installer. Also skips if package not installed.
if [[ lolang_wasoutdated -eq 0 ]]; then
  open /usr/local/Caskroom/libreoffice-language-pack/"$lolang_newvers"/'LibreOffice Language Pack.app'/
fi

# Update "greedy" packages individually
linn_konfig_outdated && brew cask upgrade --greedy linn-konfig

# Update Launchbar Actions
cd ~/Library/Application\ Support/LaunchBar/Actions/
for action in *; do
  git -C "$action" pull
done

# Update Microsoft Office
/Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate --install


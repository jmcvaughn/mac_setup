#!/bin/sh

login_items='LaunchBar'

install_packages() {
	# brew bundle doesn't support --no-quarantine. Note that this disables
	# Gatekeeper for these Casks; automating this is technically a security
	# issue!
	brew cask install --no-quarantine android-platform-tools openwebstart

	# Check LibreOffice Language Pack installed before brew bundle
	brew cask list libreoffice-language-pack &> /dev/null
	lolang_instbefore=$?

	# Install packages
	brew bundle --no-lock && hash -r

	# Get LibreOffice Language Pack version and check if installed after
	# brew bundle
	lolang_vers="$(brew cask list --versions libreoffice-language-pack 2> /dev/null | gawk 'BEGIN {rc=1} {rc=0; print $2} END {exit rc}')"
	lolang_instafter=$?

	# If the Cask has just been installed, run LibreOffice Language Pack
	# installer. Also skips if package not in Brewfile. Launching LibreOffice
	# also generates file associations.
	if [ "$lolang_instbefore" -ne 0 ] && [ "$lolang_instafter" -eq 0 ]; then
		open -ja LibreOffice && sleep 10 && pkill -x soffice
		open /usr/local/Caskroom/libreoffice-language-pack/"$lolang_vers"/'LibreOffice Language Pack.app'/
	fi

	# Install Python 3 packages
	/usr/local/bin/python3 -m pip install -r requirements.txt
}


install_launchbar_actions() {
	gmkdir -p "$HOME/Library/Application Support/LaunchBar/Actions/" > /dev/null 2>&1
	cd "$HOME/Library/Application Support/LaunchBar/Actions/"

	# https://github.com/bswinnerton/launchbar-github
	if [ ! -d github.lbaction ]; then
		git clone https://github.com/bswinnerton/launchbar-github github.lbaction
	fi

	# https://github.com/v0rn/xkcdpass.lbaction
	if [ ! -d xkcdpass.lbaction ]; then
		git clone https://github.com/v0rn/xkcdpass.lbaction xkcdpass.lbaction
	fi
}


clone_git_repos() {
	gmkdir "$HOME/git/" > /dev/null 2>&1
	cd "$HOME/git/"

	if [ ! -d markdown-css ]; then
		git clone https://github.com/otsaloma/markdown-css.git
	fi
}


set_login_items() {
	# Note: AppleScript only uses double quotes

	# Login items
	## Clear all existing login items
	IFS=','
	for item in $(osascript -e 'tell application "System Events" to get the name of every login item' | gsed 's/, /,/g'); do
		osascript -e "tell application \"System Events\" to delete login item \"$item\""
	done
	unset IFS

	# Add login items
	## Separate osascript calls, otherwise you only get output from the last to
	## run and order seems to change
	for app in $login_items; do
		osascript -e "tell application \"System Events\" to make login item at end with properties {name: \"$app\", path: \"/Applications/$app.app\", hidden: false}" > /dev/null
	done

	# Enable skhd and yabai at login
	brew services start skhd
	brew services start yabai
}


main() {
	export HOMEBREW_NO_ANALYTICS=1

	# Install Homebrew
	if ! which brew > /dev/null 2>&1; then
		# Homebrew install command, see https://brew.sh
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		hash -r
	fi

	install_packages
	install_launchbar_actions
	clone_git_repos
	vagrant plugin install vagrant-scp  # Install Vagrant plugins
	set_login_items
}

main

# vim: set filetype=bash foldmethod=syntax:

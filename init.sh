#!/bin/bash

brewzsh_in_shellsdb() {
  if ! grep -qE '^/usr/local/bin/zsh$' /etc/shells; then
    echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
  fi
}


install_pkgmgmt() {
  # Homebrew install command, see https://brew.sh
  /usr/bin/ruby -e "$(
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
  )" && hash -r

  # Install Mac App Store CLI
  brew install mas && hash -r
  read -p 'Mac App Store username: ' mas_user
  mas signin --dialog $mas_user
}


main() {
  cd $(dirname $0)  # Change to script's directory

  export HOMEBREW_NO_ANALYTICS=1

  # Install Homebrew and mas
  if ! which brew > /dev/null; then
    install_pkgmgmt
  fi

  # Install packages
  brew bundle && hash -r

  # Symlink avr-gcc 7 to avr-gcc (QMK)
  brew link --force avr-gcc@7

  # Pick up newly-installed GNU utilities
  if [[ $PATH != *'gnubin'* ]]; then
    PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export PATH
    hash -r
  fi

  # Ensure Homebrew Zsh in shells database
  brewzsh_in_shellsdb

  # Configure the system
  ./setup.sh
}

main


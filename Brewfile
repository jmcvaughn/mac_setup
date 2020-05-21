#-------------------------------------------------------------------------------
# Casks
#-------------------------------------------------------------------------------

tap 'homebrew/cask'  # Explicitly tap to keep during `brew bundle cleanup`
cask 'android-platform-tools'  # Installed using --no-quarantine by script
cask 'bitwarden'
cask 'coconutbattery'
cask 'displaycal'
cask 'docker'
cask 'drawio'
cask 'firefox'
cask 'google-chrome'
cask 'iterm2'
cask 'karabiner-elements'
cask 'launchbar'
cask 'libreoffice'
cask 'libreoffice-language-pack'
cask 'netnewswire'
cask 'qobuz'
cask 'skim'
cask 'soundsource'
cask 'telegram'
cask 'textual'
cask 'tunnelblick'
cask 'vagrant'
cask 'vagrant-manager'
cask 'virtualbox'
cask 'virtualbox-extension-pack'
cask 'whatsapp'
cask 'xquartz'
cask 'osxfuse'  # Required by sshfs
cask 'wkhtmltopdf'  # Used by pandoc to create files
# Canonical
cask 'multipass'

# Drivers
tap 'homebrew/cask-drivers'
cask 'linn-konfig'  # Not a driver, here due to Cask rules: https://git.io/fjb4S


#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------

tap 'homebrew/cask-fonts'
cask 'font-source-code-pro'


#-------------------------------------------------------------------------------
# Homebrew packages
#-------------------------------------------------------------------------------

brew 'ansible'
brew 'aria2'
brew 'bitwarden-cli'
brew 'curl'
brew 'ffmpeg'
brew 'git'
brew 'gnupg'
brew 'htop'
brew 'ipmitool'
brew 'jq'
brew 'less'
brew 'libosinfo'
brew 'neovim'
brew 'pandoc'
brew 'picocom'
brew 'pinentry-mac'
brew 'python'
brew 'sipcalc'
brew 'socat'
brew 'source-highlight'
brew 'speedtest-cli'
brew 'sshuttle'
brew 'tree'
brew 'watch'
brew 'wget'
brew 'xz'

# GNU utilities
brew 'coreutils'
brew 'diffutils'
brew 'findutils'
brew 'gawk'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'grep'
brew 'gzip'

# Window manager
tap 'homebrew/services'  # Explicitly tap to keep during `brew bundle cleanup`
tap 'koekeishiya/formulae'
brew 'yabai'
brew 'skhd'

# Zsh
brew 'zsh-autosuggestions'
brew 'zsh-completions'
brew 'zsh-history-substring-search'
brew 'zsh-syntax-highlighting'

# Canonical
brew 'lxc'
brew 'snapcraft'
## Juju
brew 'juju'
brew 'charm-tools'

# Utilities with Cask dependencies
brew 'sshfs'


#-------------------------------------------------------------------------------
# QMK
#-------------------------------------------------------------------------------

# For each group, package dependencies are listed before the dependent package,
# ensuring depedencies are kept during a `brew bundle cleanup`

tap 'qmk/qmk'
brew 'qmk'

# Build tools
# https://docs.qmk.fm/#/newbs_getting_started?id=set-up-your-environment
brew 'bootloadhid', args: ['HEAD']
brew 'clang-format'
brew 'dfu-util'

## avrdude
brew 'libelf'
brew 'libftdi0'
brew 'libhid'
brew 'avrdude'

## dfu-programmer
brew 'libusb-compat'
brew 'dfu-programmer'

tap 'osx-cross/arm'
brew 'arm-gcc-bin@8', link: true

## avr-gcc
tap 'osx-cross/avr'
brew 'avr-binutils'
brew 'isl'
brew 'libmpc'
brew 'avr-gcc@8', link: true

#!/bin/bash

system_preferences() {  # {{{
  #-----------------------------------------------------------------------------
  # Pre-tasks {{{
  #-----------------------------------------------------------------------------

  # Clear menu bar array
  /usr/libexec/PlistBuddy -c 'Delete :menuExtras' /Users/jmvaughn/Library/Preferences/com.apple.systemuiserver.plist
  /usr/libexec/PlistBuddy -c 'Add :menuExtras array' /Users/jmvaughn/Library/Preferences/com.apple.systemuiserver.plist
  # }}}


  #-----------------------------------------------------------------------------
  # General {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Appearance: Dark
  defaults write -g AppleInterfaceStyle -string 'Dark'

  ## Sidebar icon size: Small
  defaults write -g NSTableViewDefaultSizeMode -int 1

  ## Automatically hide and show the menu bar: True
  #defaults write -g _HIHideMenuBar -bool true

  ## Show scroll bars: Always
  defaults write -g AppleShowScrollBars -string 'Always'

  ## Click in the scroll bar to: Jump to the spot that's clicked
  defaults write -g AppleScrollerPagingBehaviour -bool true

  # Other
  ## Use font smoothing when available: Medium
  defaults -currentHost write -g AppleFontSmoothing -int 2

  ## Enable sub-pixel rendering globally
  defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
  # }}}


  #-----------------------------------------------------------------------------
  # Dock {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Size
  defaults write com.apple.dock tilesize -int 52

  ## Position on screen: Left
  defaults write com.apple.dock orientation -string 'left'

  ## Minimise windows using: Scale effect
  defaults write com.apple.dock mineffect -string 'scale'

  ## Double-click a window's title bar to: minimise
  defaults write -g AppleActionOnDoubleClick -string 'Minimize'

  ## Automatically hide and show the Dock: True
  defaults write com.apple.dock autohide -bool true

  ## Show recent applications in Dock: False
  defaults write com.apple.dock show-recents -bool false

  # Other
  ## Remove delay showing the Dock
  defaults write com.apple.dock autohide-delay -float 0

  ## Disable show/hide animation
  defaults write com.apple.dock autohide-time-modifier -float 0

  ## Make icons of hidden applications transparent
  defaults write com.apple.dock showhidden -bool true

  ## Remove icons
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock persistent-others -array
  # }}}


  #-----------------------------------------------------------------------------
  # Mission Control {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Automatically rearrange Spaces based on most recent use: False
  defaults write com.apple.dock mru-spaces -bool false

  ## When switching to an application, switch to a Space with open windows for the
  ## application: False
  defaults write -g AppleSpacesSwitchOnActivate -bool false

  ## Group windows by application: True
  defaults write com.apple.dock expose-group-apps -bool true

  ## Displays have separate Spaces: False
  defaults write com.apple.spaces spans-displays -bool false
  # }}}


  #-----------------------------------------------------------------------------
  # Displays {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Show mirroring options in the menu bar when available
  #defaults write com.apple.airplay showInMenuBarIfPresent -bool false
  # }}}


  #-----------------------------------------------------------------------------
  # Energy Saver {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Show battery status in menu bar
  defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.battery' -bool true
  /usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Battery.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

  ## Battery > Turn display off after: 5 minutes
  sudo pmset -b displaysleep 5

  ## Battery > Slightly dim the display while on battery power: False
  sudo pmset -b lessbright 0

  ## Battery > Enable Power Nap while on battery power: True
  sudo pmset -b powernap 1

  ## Power Adapter > Prevent computer from sleeping automatically when the display is off: True
  sudo pmset -c sleep 0

  ## Power Adapter > Turn display off after: 15 minutes
  sudo pmset -c displaysleep 15

  ## Power Adapter > Enable Power Nap while plugged into a power adapter: True
  sudo pmset -c powernap 1

  # Other
  ## Disable Sudden Motion Sensor
  sudo pmset -a sms 0

  ## Restart on freeze
  sudo systemsetup -setrestartfreeze on

  # Battery menu
  ## Show Percentage: True
  defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

  ## Position
  defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.battery" -float 241
  # }}}


  #-----------------------------------------------------------------------------
  # Keyboard {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Keyboard > Key repeat: Fastest, Delay Until Repeat: Shortest
  defaults write -g InitialKeyRepeat -int 15  # Seems to adjust both
  defaults write -g KeyRepeat -int 2  # Seems to always be set to 2

  ## Text > Correct spelling automatically: False
  defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

  ## Text > Capitalise word Automatically: False
  defaults write -g NSAutomaticCapitalizationEnabled -bool false

  ## Text > Add full stop with double space: False
  defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

  ## Text > Use smart quotes and dashes: False
  defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

  ## Shortcuts > Full keyboard access: All controls
  defaults write -g AppleKeyboardUIMode -int 3

  # Other
  ## Automatic text completion - verify what this does, Touch Bar? Option-Esc?
  defaults write -g NSAutomaticTextCompletionEnabled -bool false
  # }}}


  #-----------------------------------------------------------------------------
  # Mouse {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Tracking speed: Slowest (eliminates acceleration but slows tracking)
  defaults write -g com.apple.mouse.scaling -float 0

  ## Scrolling speed: Slowest (eliminates acceleration but slows tracking)
  defaults write -g com.apple.scrollwheel.scaling -float 0
  # }}}


  #-----------------------------------------------------------------------------
  # Trackpad {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Point & Click > Tap to click: True
  defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

  ## Point & Click > Click: Light
  defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
  defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

  ## Point & Click > Tracking speed
  defaults write -g com.apple.trackpad.scaling -float 0.875

  ## More Gestures > Swipe between full-screen apps: Swipe left or right with four fingers
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
  defaults -currentHost write -g com.apple.trackpad.fourFingerHorizSwipeGesture -int 2

  ## More Gestures > Mission Control: Swipe up with four fingers
  defaults write com.apple.dock showMissionControlGestureEnabled -bool true

  ## More Gestures > Launchpad: False
  defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
  # }}}


  #-----------------------------------------------------------------------------
  # Sound {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Sound Effects > Play user interface sound effects
  defaults write -g com.apple.sound.uiaudio.enabled -int 0

  ## Show volume in menu bar
  defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.volume' -bool true
  /usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Volume.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

  # Volume menu position
  defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.volume" -float 352
  # }}}


  #-----------------------------------------------------------------------------
  # Network {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Wi-Fi > Show Wi-Fi status in menu bar: True
  defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.airport' -bool true
  /usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/AirPort.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

  # Wi-Fi menu position
  defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.airport" -float 322
  # }}}


  #-----------------------------------------------------------------------------
  # Bluetooth {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Show Bluetooth in menu bar
  defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.bluetooth' -bool true
  /usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Bluetooth.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

  # Bluetooth menu position
  defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.bluetooth" -float 292
  # }}}


  #-----------------------------------------------------------------------------
  # Date & Time {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Clock > Show date and time in menu bar: True
  defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.clock' -bool true
  /usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Clock.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

  ## * indicates default
  ## Clock:
  ##   Time options:
  ##     Display the time with seconds: True
  ##     Use a 24-hour clock: True*
  ##   Date options
  ##     Show the day of the week: True*
  ##     Show date: True
  defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM  HH:mm:ss'

  # Clock menu position
  defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.clock" -float 103.0273
  # }}}


  #-----------------------------------------------------------------------------
  # Accessibility {{{
  #-----------------------------------------------------------------------------

  # System Preferences
  ## Display > Reduce Transparency
  defaults write com.apple.universalaccess reduceTransparency -bool true

  ## Mouse & Trackpad > Trackpad Options > Enable dragging: three finger drag
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
  # }}}
}  # }}}


other_preferences(){  # {{{
  # Measure lengths in cm
  defaults write -g AppleMeasurementUnits -string 'Centimeters'

  # Disable special key pop-up on press-and-hold
  defaults write -g ApplePressAndHoldEnabled -bool false

  # Remove springing delay (0 means only slight delay)
  defaults write -g com.apple.springing.delay -float 0

  # Disable Automatic Termination
  defaults write -g NSDisableAutomaticTermination -bool true

  # Expand panels
  defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
  defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
  defaults write -g PMPrintingExpandedStateForPrint -bool true
  defaults write -g PMPrintingExpandedStateForPrint2 -bool true

  # Make Cocoa application resize time virtually instantaneous
  defaults write -g NSWindowResizeTime -float 0.001

  # Silence boot chime
  # None of these seem to work on 13" MacBookAir6,2
  #sudo nvram SystemAudioVolume=' '
  #sudo nvram SystemAudioVolume=%00
  #sudo nvram SystemAudioVolume=%01
  #sudo nvram SystemAudioVolume=%80

  # Unhide /Volumes/
  sudo chflags nohidden /Volumes/
}  # }}}


ad_blocking(){  # {{{
  # Download blocking hosts file
  sudo https_proxy=$https_proxy curl --show-error --silent \
    https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts \
    --output /etc/hosts
}  # }}}

main() {
  cd "$(dirname $0)"  # Change to script's directory

  system_preferences
  other_preferences
  ad_blocking
}

main

# vim: set foldmethod=marker:


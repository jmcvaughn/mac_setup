#!/bin/bash

cd $(dirname $0)  # Change to script's directory

#-------------------------------------------------------------------------------
# To do after execution or to automate later
#-------------------------------------------------------------------------------

# System Preferences
#   Desktop & Screen Saver:
#     Desktop:
#       Custom Colour: '#282828'  # gruvbox bg0
#
#   Security & Privacy:
#     Advanced:
#       Require an administrator password to access system-wide preferences: True
#
#   Displays:
#     Display:
#       Automatically adjust brightness: False
#     Arrangement: Menu bar to external
#
#   Keyboard:
#     Keyboard:
#       Adjust keyboard brightness in low light: False
#       Modifier Keys:
#         Apple Internal Keyboard/Trackpad:
#           Caps Lock: Control
#           Control: False
#     Shortcuts:
#       Mission Control:
#         Switch to Desktop [1-10]: ^[1-0]
#       Spotlight:
#         Show Spotlight search: False
#
#   Users & Groups:
#     Password:
#       Picture: Piano
#
# Menu bar:
#   - Dozer:
#     - ...
#     - Spotlight
#   - WhichSpace
#   - Cisco AnyConnect
#   - System icons

# Notification Centre:
#   World Clock:
#     - Hillsboro
# 
# Applications:
#   Cisco AnyConnect:
#     Start VPN when AnyConnect is started: True
# 
#   CrashPlan:
#     Preferences:
#       Show Code42 CrashPlan status in menu bar: False
#     jmvaughn-mac01 Backup:
#       Manage Files:
#         - /Users/jmvaughn/Documents/
#       Backup Set Settings:
#         File Exclusions:
#           - $RECYCLE.BIN
#           - desktop.ini
#           - .DS_Store
#
#   Office:
#     Cloud Storage: Skip
#     Preferences:
#       Privacy:
#         Office Intelligent Services: False
#
#   Skype for Business:
#     Switch to (audio device):
#       DisplayPort:
#         Switch: False
#         Don't show again for this device: True
#       WH-1000XM3:
#         Switch: True
#         Don't show again for this device: True
#
#   Word:
#     Preferences:
#       AutoCorrect:
#         Capitalize first letter of sentences: False
#       User Information:
#         - Complete all
# 
#   Slack:
#     Messages \& Media:
#       Theme: Compact
#       Show times with 24-hour clock: True
#
#   SwitchResX:
#     Helper Modules:
#       - Update System Integrity Protection
#     Acer B346CK:
#       Custom Resolutions:
#         3440 x 1440, 50Hz:
#           Use simplified settings: CVT-RB
#           Vertical Scan Rate (Hz): 49.999
#
# Other tasks:
#   - Set Skim as default PDF reader


# System Preferences {{{
#-------------------------------------------------------------------------------
# Pre-tasks
#-------------------------------------------------------------------------------

# Clear menu bar array
/usr/libexec/PlistBuddy -c 'Delete :menuExtras' /Users/jmvaughn/Library/Preferences/com.apple.systemuiserver.plist
/usr/libexec/PlistBuddy -c 'Add :menuExtras array' /Users/jmvaughn/Library/Preferences/com.apple.systemuiserver.plist


#-------------------------------------------------------------------------------
# General
#-------------------------------------------------------------------------------

## System Preferences
# Appearance: Dark
defaults write -g AppleInterfaceStyle -string 'Dark'

# Sidebar icon size: Small
defaults write -g NSTableViewDefaultSizeMode -int 1

# Automatically hide and show the menu bar: True
#defaults write -g _HIHideMenuBar -bool true

# Show scroll bars: Always
defaults write -g AppleShowScrollBars -string 'Always'

# Click in the scroll bar to: Jump to the spot that's clicked
defaults write -g AppleScrollerPagingBehaviour -bool true

## Other
# Use font smoothing when available: Medium
defaults -currentHost write -g AppleFontSmoothing -int 2

# Enable sub-pixel rendering globally
defaults write -g CGFontRenderingFontSmoothingDisabled -bool false


#-------------------------------------------------------------------------------
# Dock
#-------------------------------------------------------------------------------

## System Preferences
# Size
defaults write com.apple.dock tilesize -int 52

# Position on screen: Left
defaults write com.apple.dock orientation -string 'left'

# Minimise windows using: Scale effect
defaults write com.apple.dock mineffect -string 'scale'

# Double-click a window's title bar to: minimise
defaults write -g AppleActionOnDoubleClick -string 'Minimize'

# Automatically hide and show the Dock: True
defaults write com.apple.dock autohide -bool true

# Show recent applications in Dock: False
defaults write com.apple.dock show-recents -bool false

## Other
# Remove delay showing the Dock
defaults write com.apple.dock autohide-delay -float 0

# Disable show/hide animation
defaults write com.apple.dock autohide-time-modifier -float 0

# Make icons of hidden applications transparent
defaults write com.apple.dock showhidden -bool true

# Remove icons
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array


#-------------------------------------------------------------------------------
# Mission Control
#-------------------------------------------------------------------------------

## System Preferences
# Automatically rearrange Spaces based on most recent use: False
defaults write com.apple.dock mru-spaces -bool false

# When switching to an application, switch to a Space with open windows for the application: False
defaults write -g AppleSpacesSwitchOnActivate -bool false

# Group windows by application: True
defaults write com.apple.dock expose-group-apps -bool true

# Displays have separate Spaces: False
defaults write com.apple.spaces spans-displays -bool false


#-------------------------------------------------------------------------------
# Displays
#-------------------------------------------------------------------------------

## System Preferences
# Show mirroring options in the menu bar when available
#defaults write com.apple.airplay showInMenuBarIfPresent -bool false


#-------------------------------------------------------------------------------
# Energy Saver
#-------------------------------------------------------------------------------

## System Preferences
# Show battery status in menu bar
defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.battery' -bool true
/usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Battery.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

# Battery > Turn display off after: 5 minutes
sudo pmset -b displaysleep 5

# Battery > Slightly dim the display while on battery power: False
sudo pmset -b lessbright 0

# Battery > Enable Power Nap while on battery power: True
sudo pmset -b powernap 1

# Power Adapter > Prevent computer from sleeping automatically when the display is off: True
sudo pmset -c sleep 0

# Power Adapter > Turn display off after: 15 minutes
sudo pmset -c displaysleep 15

# Power Adapter > Enable Power Nap while plugged into a power adapter: True
sudo pmset -c powernap 1

## Other
# Disable Sudden Motion Sensor
sudo pmset -a sms 0

# Restart on freeze
sudo systemsetup -setrestartfreeze on

## Battery menu
# Show Percentage: True
defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

# Position
defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.battery" -float 241


#-------------------------------------------------------------------------------
# Keyboard
#-------------------------------------------------------------------------------

## System Preferences
# Keyboard > Key repeat: Fastest, Delay Until Repeat: Shortest
defaults write -g InitialKeyRepeat -int 15  # Seems to adjust both
defaults write -g KeyRepeat -int 2  # Seems to always be set to 2

# Text > Correct spelling automatically: False
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Text > Capitalise word Automatically: False
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# Text > Add full stop with double space: False
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Text > Use smart quotes and dashes: False
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Shortcuts > Full keyboard access: All controls
defaults write -g AppleKeyboardUIMode -int 3

## Other
# Automatic text completion - verify what this does, Touch Bar? Option-Esc?
defaults write -g NSAutomaticTextCompletionEnabled -bool false


#-------------------------------------------------------------------------------
# Mouse
#-------------------------------------------------------------------------------

## System Preferences
# Tracking speed: Slowest (eliminates acceleration but slows tracking)
defaults write -g com.apple.mouse.scaling -float 0

# Scrolling speed: Slowest (eliminates acceleration but slows tracking)
defaults write -g com.apple.scrollwheel.scaling -float 0


#-------------------------------------------------------------------------------
# Trackpad
#-------------------------------------------------------------------------------

## System Preferences
# Point & Click > Tap to click: True
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

# Point & Click > Click: Light
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Point & Click > Tracking speed
defaults write -g com.apple.trackpad.scaling -float 0.875

# More Gestures > Swipe between full-screen apps: Swipe left or right with four fingers
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults -currentHost write -g com.apple.trackpad.fourFingerHorizSwipeGesture -int 2

# More Gestures > Mission Control: Swipe up with four fingers
defaults write com.apple.dock showMissionControlGestureEnabled -bool true

# More Gestures > Launchpad: False
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false


#-------------------------------------------------------------------------------
# Sound
#-------------------------------------------------------------------------------

## System Preferences
# Sound Effects > Play user interface sound effects
defaults write -g com.apple.sound.uiaudio.enabled -int 0

# Show volume in menu bar
defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.volume' -bool true
/usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Volume.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

## Volume menu position
defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.volume" -float 352


#-------------------------------------------------------------------------------
# Network
#-------------------------------------------------------------------------------

## System Preferences
# Wi-Fi > Show Wi-Fi status in menu bar: True
defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.airport' -bool true
/usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/AirPort.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

## Wi-Fi menu position
defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.airport" -float 322



#-------------------------------------------------------------------------------
# Bluetooth
#-------------------------------------------------------------------------------

## System Preferences
# Show Bluetooth in menu bar
defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.bluetooth' -bool true
/usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Bluetooth.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

## Bluetooth menu position
defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.bluetooth" -float 292


#-------------------------------------------------------------------------------
# Users & Groups
#-------------------------------------------------------------------------------

## Login items
# Note: AppleScript requires double quotes
# Clear all existing login items
IFS=','
for item in $(osascript -e \
  'tell application "System Events" to get the name of every login item' \
    | sed 's/, /,/g'
); do
  osascript -e "tell application \"System Events\" to delete login item \"$item\""
done
unset IFS

# Add login items
# Separate osascript calls as you otherwise only get output from the last to
# run and order seems to change
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Alfred 3", path: "/Applications/Alfred 3.app", hidden: false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Amethyst", path: "/Applications/Amethyst.app", hidden: false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Dozer", path: "/Applications/Dozer.app", hidden: false}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {name: "WhichSpace", path: "/Applications/WhichSpace.app", hidden: false}' > /dev/null


#-------------------------------------------------------------------------------
# Date & Time
#-------------------------------------------------------------------------------

## System Preferences
# Clock > Show date and time in menu bar: True
defaults write com.apple.systemuiserver 'NSStatusItem Visible com.apple.menuextra.clock' -bool true
/usr/libexec/PlistBuddy -c 'Add :menuExtras: string /System/Library/CoreServices/Menu\ Extras/Clock.menu' ~/Library/Preferences/com.apple.systemuiserver.plist

# * indicates default
# Clock:
#   Time options:
#     Display the time with seconds: True
#     Use a 24-hour clock: True*
#   Date options
#     Show the day of the week: True*
#     Show date: True
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM  HH:mm:ss'

## Clock menu position
defaults write com.apple.systemuiserver "NSStatusItem Preferred Position com.apple.menuextra.clock" -float 103.0273


#-------------------------------------------------------------------------------
# Accessibility
#-------------------------------------------------------------------------------

## System Preferences
# Display > Reduce Transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Mouse & Trackpad > Trackpad Options > Enable dragging: three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
# }}}

# Applications {{{
#-------------------------------------------------------------------------------
# Finder
# Defaults are set explicitly to revert on script run if changed
#-------------------------------------------------------------------------------

## Finder Preferences
# General > Show these items on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true  # default
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false  # default
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true  # default

# General > New Finder windows show: user home
defaults write com.apple.finder NewWindowTarget -string 'PfHm'
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

# Advanced > Show all filename extensions: True
defaults write -g AppleShowAllExtensions -bool true

# Advanced > Show warning before changing an extension: False
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Advanced > Show warning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Advanced > Show warning before emptying the Trash: False
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Advanced > Keep folders on top: In windows when sorting by name: True
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Advanced > Keep folders on top: On Desktop: True
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Advanced > When performing a search: Search the Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'  # default?

## View menu options
# Applies to window regardless of view
defaults write com.apple.finder ShowPathbar -bool true

# For icon and list views only; column view is set as part of ColumnViewOptions
defaults write com.apple.finder ShowPreviewPane -bool false  # default
defaults write com.apple.finder ShowSidebar -bool true  # default
defaults write com.apple.finder ShowStatusBar -bool true

## View Options
# Desktop view
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorBlue 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorGreen 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorRed 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundType 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridOffsetX 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridOffsetY 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 57' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 56' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo 1' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 11' ~/Library/Preferences/com.apple.finder.plist

# Column view
# Finder only; not sure how to set this for dialogs (e.g. Save, Print)
/usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ArrangeBy dnam' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ColumnShowIcons 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:FontSize 11' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ShowIconThumbnails 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ShowPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default

# List view
# No need to set StandardViewSettings:ListViewSettings, ends up matching these
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:iconSize 16' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:textSize 11' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:useRelativeDates 1' ~/Library/Preferences/com.apple.finder.plist  # default
# For in-app dialogs, e.g. Print, Save
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:calculateAllSizes 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:iconSize 16' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:sortColumn name' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:textSize 11' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:useRelativeDates 1' ~/Library/Preferences/com.apple.finder.plist  # default

# Icon view
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorBlue 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorGreen 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorRed 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundType 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridOffsetX 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridOffsetY 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 54' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 56' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo 1' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 11' ~/Library/Preferences/com.apple.finder.plist
# For in-app dialogs, e.g. Print, Save
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorBlue 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorGreen 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorRed 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundType 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridOffsetX 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridOffsetY 0' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 54' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:iconSize 56' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:labelOnBottom 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showItemInfo 1' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:textSize 11' ~/Library/Preferences/com.apple.finder.plist

# Gallery view
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:iconSize 48' ~/Library/Preferences/com.apple.finder.plist  # default
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:showIconPreview 1' ~/Library/Preferences/com.apple.finder.plist  # default

## Other
# Show absolute path as window title
# Commented out as path bar is clearer and allows copy/paste
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable all animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Info pane expanded sections
# MetaData: 'More Info', Name: 'Name & Extension', Privileges: 'Sharing & Permissions'
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  MetaData -bool false \
  Name -bool false \
  Comments -bool false \
  OpenWith -bool false \
  Preview -bool false \
  Privileges -bool true

# Default to column view
defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'

# Collapse Tags section in sidebar
defaults write com.apple.finder SidebarTagsSctionDisclosedState -bool false

# Disable .DS_Store file creation on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores true


#-------------------------------------------------------------------------------
# Skype for Business
#-------------------------------------------------------------------------------

# General > Prompt me before leaving a call: False
defaults write com.microsoft.SkypeForBusiness showEndCallDialog -bool false

# General > Show my video for incoming calls: False
defaults write com.microsoft.SkypeForBusiness showVideoPreviewForIncomingCalls -bool false

# Calls > Before joining a meeting, ask me which audio device I want to use: False, Use Skype for Business
defaults write com.microsoft.SkypeForBusiness shouldPromptForJoinMeetingType -bool false
defaults write com.microsoft.SkypeForBusiness joinWithAudioKind -int 0

## Other
# Get rid of first run welcome screen
defaults write com.microsoft.SkypeForBusiness firstRun -bool false


#-------------------------------------------------------------------------------
# Other
#-------------------------------------------------------------------------------

# Disable automatic updates for unmanaged apps
apps_disable_update_check=(
  'com.amethyst.Amethyst'
  'com.docker.docker'
  'com.mortennn.Dozer'
  'io.gechr.WhichSpace'
  'net.sourceforge.skim-app.skim'
)
for app in $apps_disable_update_check; do
  defaults write $app SUEnableAutomaticChecks -bool true
  defaults write $app SUHasLaunchedBefore -bool true
done
# }}}


#-------------------------------------------------------------------------------
# Other
#-------------------------------------------------------------------------------

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

# Change user default shell to Homebrew Zsh
chsh -s /usr/local/bin/zsh

# Download blocking hosts file
sudo https_proxy=$https_proxy curl --show-error --silent \
  https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts \
  --output /etc/hosts

# Copy zsh configuration
for i in zsh/*; do
  cp -r $i $HOME/.$(basename $i)
done


#-------------------------------------------------------------------------------
# Power management and hardware
#-------------------------------------------------------------------------------

# Silence boot chime
# None of these seem to work on 13" MacBookAir6,2
#sudo nvram SystemAudioVolume=' '
#sudo nvram SystemAudioVolume=%00
#sudo nvram SystemAudioVolume=%01
#sudo nvram SystemAudioVolume=%80


#-------------------------------------------------------------------------------
# Unhide directories
#-------------------------------------------------------------------------------

# ~/Library/ is hidden using com.apple.FinderInfo extended attribute, but for
# some reason, `xattr -d com.apple.FinderInfo ~/Library/` doesn't work. For
# now, use View Options to unhide it.

sudo chflags nohidden /Volumes/

# vim: set foldmethod=marker:


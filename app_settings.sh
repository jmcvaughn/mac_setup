#!/usr/bin/env sh

dozer() {
  # Hide status bar icons after 10 seconds: True
  defaults write com.mortennn.Dozer hideAfterDelayEnabled -bool true
}


finder() {
  # Defaults are set explicitly to revert on script run if changed
  finder_plist="$HOME/Library/Preferences/com.apple.finder.plist"

  # Finder Preferences
  ## General > Show these items on the desktop
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true  # default
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false  # default
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true  # default

  ## General > New Finder windows show: user home
  defaults write com.apple.finder NewWindowTarget -string 'PfHm'
  defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

  ## Advanced > Show all filename extensions: True
  defaults write -g AppleShowAllExtensions -bool true

  ## Advanced > Show warning before changing an extension: False
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  ## Advanced > Show warning before removing from iCloud Drive
  defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

  ## Advanced > Show warning before emptying the Trash: False
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  ## Advanced > Keep folders on top: In windows when sorting by name: True
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  ## Advanced > Keep folders on top: On Desktop: True
  defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

  ## Advanced > When performing a search: Search the Current Folder
  defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'  # default?

  # View menu options
  ## Applies to window regardless of view
  defaults write com.apple.finder ShowPathbar -bool true

  ## For icon and list views only; column view is set as part of ColumnViewOptions
  defaults write com.apple.finder ShowPreviewPane -bool false  # default
  defaults write com.apple.finder ShowSidebar -bool true  # default
  defaults write com.apple.finder ShowStatusBar -bool true

  # View Options
  ## Desktop view
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy none' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorBlue 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorGreen 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundColorRed 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:backgroundType 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridOffsetX 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridOffsetY 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 57' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 56' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showIconPreview 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo 1' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 11' "$finder_plist"

  ## Column view
  ## Finder only; not sure how to set this for dialogs (e.g. Save, Print)
  /usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ArrangeBy dnam' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ColumnShowIcons 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:FontSize 11' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ShowIconThumbnails 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewOptions:ColumnViewOptions:ShowPreview 1' "$finder_plist"  # default

  ## List view
  ## No need to set StandardViewSettings:ListViewSettings, gets copied somehow
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:iconSize 16' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:showIconPreview 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:sortColumn name' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:textSize 11' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:useRelativeDates 1' "$finder_plist"  # default
  ## For in-app dialogs, e.g. Print, Save
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:calculateAllSizes 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:iconSize 16' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:showIconPreview 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:sortColumn name' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:textSize 11' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :FK_DefaultListViewSettingsV2:useRelativeDates 1' "$finder_plist"  # default

  ## Icon view
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy none' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorBlue 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorGreen 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundColorRed 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:backgroundType 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridOffsetX 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridOffsetY 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 54' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 56' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showIconPreview 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo 1' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 11' "$finder_plist"
  ## For in-app dialogs, e.g. Print, Save
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy none' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorBlue 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorGreen 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundColorRed 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:backgroundType 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridOffsetX 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridOffsetY 0' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 54' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:iconSize 56' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:labelOnBottom 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showIconPreview 1' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:showItemInfo 1' "$finder_plist"
  /usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:textSize 11' "$finder_plist"

  ## Gallery view
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:arrangeBy none' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:iconSize 48' "$finder_plist"  # default
  /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:GalleryViewSettings:showIconPreview 1' "$finder_plist"  # default

  # Other
  ## Show absolute path as window title
  ## Commented out as path bar is clearer and allows copy/paste
  #defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  ## Disable all animations
  defaults write com.apple.finder DisableAllAnimations -bool true

  ## Expand info pane sections
  ## Get Info window sections:
  ## MetaData: 'More Info'
  ## Name: 'Name & Extension'
  ## Privileges: 'Sharing & Permissions'
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    MetaData -bool false \
    Name -bool false \
    Comments -bool false \
    OpenWith -bool false \
    Preview -bool false \
    Privileges -bool true

  ## Default to column view
  defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'

  ## Collapse Tags section in sidebar
  defaults write com.apple.finder SidebarTagsSctionDisclosedState -bool false

  ## Disable .DS_Store file creation on network and USB volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
  defaults write com.apple.desktopservices DSDontWriteUSBStores true
}


launchbar() {
  # Preferences
  ## General > Open Location > Prefer secure URL schemes: True
  defaults write at.obdev.LaunchBar OpenLocationPreferSecureSchemes -bool true

  ## General > Open Location > Automatically prefix hostname with 'www': False
  defaults write at.obdev.LaunchBar OpenLocationPrependWWW -bool false

  ## Appearance > Theme: Dark
  defaults write at.obdev.LaunchBar Theme -string 'at.obdev.LaunchBar.theme.Dark'

  ## Shortcuts > Keyboard Shortcuts > Search in Spotlight: False
  defaults write at.obdev.LaunchBar SpotlightHotKeyEnabled -bool false

  ## Shortcuts > Modifier Taps > Instant Send: Double Command
  defaults write at.obdev.LaunchBar ModifierTapInstantSend -int 21

  ## Shortcuts > Browsing > Instant Info Browsing: True
  defaults write at.obdev.LaunchBar InstantInfoBrowsing -bool true

  ## Actions > Preferred Terminal application: iTerm
  defaults write at.obdev.LaunchBar PreferredTerminal -int 1

  ## Actions > Create emails with: Microsoft Outlook
  defaults write at.obdev.LaunchBar EmailHandler -string 'com.microsoft.Outlook'

  ## Update > Automatically check for updates: False
  defaults write at.obdev.LaunchBar SoftwareUpdateCheckAutomatically -bool false

  ## Advanced > Show Dock Icon: False
  defaults write at.obdev.LaunchBar ShowDockIcon -bool false

  # Other
  ## Set user defaults version (otherwise theme needs to be set manually)
  defaults write at.obdev.LaunchBar UserDefaultsVersion -int 6

  ## Skip welcome screen
  defaults write at.obdev.LaunchBar WelcomeWindowVersion -int 2
}


safari() {
  safari_plist="$HOME/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist"

  # Start Safari to create fresh plist, required for toolbar configuration
  open /Applications/Safari.app/ && sleep 10 && pkill -x Safari

  # Preferences
  ## General > New windows/tabs open with: Empty Page
  defaults write com.apple.Safari NewWindowBehavior -int 1
  defaults write com.apple.Safari NewTabBehavior -int 1

  ## General > Homepage: Intel Circuit
  if hostname | ggrep -q '.intel.com'; then
    defaults write com.apple.Safari HomePage -string 'https://employeecontent.intel.com/content/news/home/circuithome.html'
  fi

  ## General > Open "safe" files after downloading: False
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  ## General > Remove download list items: When Safari quits
  defaults write com.apple.Safari DownloadsClearingPolicy -int 1

  ## Search > Enable Quick Website search
  defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false

  # Menu options
  ## View > Show status bar: True
  defaults write com.apple.Safari ShowOverlayStatusBar -bool true

  # Other
  ## Toolbar:
  ### Clear toolbar array
  /usr/libexec/PlistBuddy -c 'Delete :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers"' "$safari_plist" > /dev/null 2>&1
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers" array' "$safari_plist"

  ### Add toolbar items:
  # Back/Forward, Home, Flexible Space, Address and Search, Flexible Space, Share
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string BackForwardToolbarIdentifier' "$safari_plist"
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string HomeToolbarIdentifier' "$safari_plist"
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string NSToolbarFlexibleSpaceItem' "$safari_plist"
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string InputFieldsToolbarIdentifier' "$safari_plist"
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string NSToolbarFlexibleSpaceItem' "$safari_plist"
  /usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration BrowserToolbarIdentifier-v2":"TB Item Identifiers": string ShareToolbarIdentifier' "$safari_plist"
}


skype_for_business() {
  # Preferences
  ## General > Prompt me before leaving a call: False
  defaults write com.microsoft.SkypeForBusiness showEndCallDialog -bool false

  ## General > Show my video for incoming calls: False
  defaults write com.microsoft.SkypeForBusiness showVideoPreviewForIncomingCalls -bool false

  ## Contacts > Prompt me before deleting a contact group
  defaults write com.microsoft.SkypeForBusiness showDeleteGroupDialog -bool false

  ## Calls > Before joining a meeting, ask me which audio device I want to use: False, Use Skype for Business
  defaults write com.microsoft.SkypeForBusiness shouldPromptForJoinMeetingType -bool false
  defaults write com.microsoft.SkypeForBusiness joinWithAudioKind -int 0

  # Other
  ## Get rid of first run welcome screen
  defaults write com.microsoft.SkypeForBusiness firstRun -bool false
}


disable_autoupdates() {
  apps_disable_update_check='
    com.docker.docker
    com.mortennn.Dozer
    net.sourceforge.skim-app.skim'

  for app in $apps_disable_update_check; do
    defaults write $app SUEnableAutomaticChecks -bool false
    defaults write $app SUHasLaunchedBefore -bool true
  done
}


main() {
  dozer
  finder
  launchbar
  safari
  skype_for_business
  disable_autoupdates
}

main

# vim: set filetype=bash foldmethod=syntax:

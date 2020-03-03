# mac_setup
Configuration scripts for my Mac

# Cloning
```
$ git clone https://github.com/v0rn/mac_setup.git && git -C mac_setup submodule update --init
```

# macOS intial setup
It is presumed that the most restrictive, least data-gathering, and least nuisance settings will be used (e.g. Ask Siri and Screen Time disabled) hence why these are not configured here.

# Usage
1) Go to System Preferences > Security & Privacy > Privacy > Full Disk Access, add and enable Terminal
2) Run `xcode-select --install ` to install Xcode Command Line Tools
3) Run `packages.sh`
4) Run `user.sh`
5) Run `system_settings.sh` and `app_settings.sh` in any order
6) Reboot
7) Launch applications:
  - Karabiner to set up the virtual keyboard device
  - Telegram to enable its Share Menu extension
8) Perform tasks specified in `manual_tasks.yaml`
9) Run `app_settings.sh` again to move AdGuard's toolbar icon to the correct location in Safari
10) Launch LaunchBar

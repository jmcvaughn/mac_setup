# mac_setup
Configuration scripts for my Mac

## Cloning
```
$ git clone https://github.com/jmcvaughn/mac_setup.git && git -C mac_setup submodule update --init
```

## macOS intial setup
It is presumed during the setup process the following was performed:

- Express Set Up was used (i.e. just click Continue)
- Analytics data was not allowed to be shared (i.e. just click Continue)
- Screen Time was not set up (click Set Up Later)
- Enable Ask Siri was deselected

Other settings are irrelevant.

## Usage
1) Go to System Preferences > Security & Privacy > Privacy > Full Disk Access, add and enable Terminal
2) Run `xcode-select --install ` to install Xcode Command Line Tools
3) Run `packages.sh`
4) Run `user.sh`
5) Run `system_settings.sh`
6) Reboot
7) Launch applications:
    - Bitwarden to enable its Safari extension
    - Karabiner to set up the virtual keyboard device
    - Telegram to enable its Share Menu extension
8) Perform tasks specified in `manual_tasks.yaml`
9) Run `app_settings.sh`
10) Relaunch/launch applications as required that are managed by `app_settings.sh`

## Catbot Setup

Setup scripts for cat-bots (cathook navbots)
For more information, visit [Cathook](https://github.com/nullworks/cathook/)

After the install script finished successfully, navmesh files have to be moved into your tf2 maps directory.  
They can be found [here](https://github.com/nullworks/catbot-database).

Due to steam recently adding Recaptcha v2, you must provide accounts to the account-generator. More information in [this](https://t.me/sag_bot) Channel.

For support, visit us in [this](https://t.me/nullworks) channel.

## Required Dependencies
Ubuntu/Debian
`sudo apt-get install nodejs firejail net-tools x11-xserver-utils`

Fedora/Centos
`sudo dnf install nodejs firejail net-tools xorg-x11-server-utils`

Arch/Manjaro (High Support)
`sudo pacman -Syu nodejs npm firejail net-tools xorg-xhost`

`xorg-server-xvfb` Is also reqiured for this fork due to unknown reasons why steam will not open unless you use it.

While starting bots, make sure that only ONE IS STARTING AT A TIME OTHERWISE THEY WILL NOT START
For whatever reason, more than one starting will cause them not to start at all

You will also never see the popup for steam or tf2, but a good way to make sure its working is looking in `cathook-ipc-web-panel/logs` OR watching the bot state until it goes to RUNNING

Confirmed to be working on Arch Linux.

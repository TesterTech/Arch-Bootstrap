#!/bin/bash

echo "Aftercare script"
pacman -Sy
pacman -S --noconfirm dhclient vim lvm2 linux-firmware dialog iw dhcpcd networkmanager sudo emacs firefox neofetch obs-studio chromium git tinyxml2 kdiff3 remmina freerdp krita gimp fuse2 fuse3 libreoffice-fresh-nl mc man-pages man terminus-font terminus-font-otb rxvt-unicode rxvt-unicode-terminfo virtualbox vagrant virtualbox-sdk i3 dmenu rofi clipmenu perl-anyevent-i3 copyq python-pytest-runner python-mock  python-cached-property python-docopt python-texttable python-websocket-client python-docker python-dockerpty python-jsonschema python-paramiko npm maven 

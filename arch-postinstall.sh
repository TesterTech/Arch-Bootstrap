#!/bin/bash
echo "Don't forget to change the rootpassword, like I did in the video: "
passwd
echo "Run the rest of the aftercare script now ... "
# The file mkinitcpio.conf on github has already the right settings for my config:
# add i915 for intel graphics and add lvm2 in the hooks
# After pacman installs 
echo "Get the mkinitcpio.conf from github"
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/master/mkinitcpio.conf' -o /etc/mkinitcpio.conf
pacman -Sy
pacman -S --noconfirm dhclient lvm2 linux-lts linux-lts-headers linux-firmware dialog iw \
                      dhcpcd networkmanager sudo emacs firefox neofetch obs-studio chromium git \
                      tinyxml2 kdiff3 remmina freerdp krita gimp fuse2 fuse3 libreoffice-fresh-nl mc \
                      man-pages man terminus-font terminus-font-otb rxvt-unicode rxvt-unicode-terminfo \
                      virtualbox vagrant virtualbox-sdk i3 dmenu rofi clipmenu perl-anyevent-i3 copyq \
                      python-pytest-runner python-mock  python-cached-property python-docopt \
                      python-texttable python-websocket-client python-docker python-dockerpty \
                      python-jsonschema python-paramiko npm maven
#!/bin/bash
echo "Don't forget to change the root password:"
passwd
echo "Run the rest of the aftercare script now ... "
# The file mkinitcpio.conf on github has already the right settings for my config:
# add i915 for intel graphics and add lvm2 in the hooks
# After pacman installs 
echo "Get the mkinitcpio.conf from github"
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/master/mkinitcpio.conf' -o /etc/mkinitcpio.conf
sudo cp -f /tmp/fstab /etc/fstab
pacman -Syu
pacman -S --noconfirm base egl-wayland kwayland-server \
	              dhclient lvm2 linux-lts linux-lts-headers linux-firmware dialog iw \
                      mc dhcpcd networkmanager sudo firefox git konsole 
pacman -S --noconfirm --needed xorg sddm plasma kde-applications

#dhclient eno1

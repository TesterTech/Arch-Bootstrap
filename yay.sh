#!/bin/bash
# As a regular user setup yay, this can best be done from withing the booted Arch Linux though.
# These steps are from https://github.com/Jguer/yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

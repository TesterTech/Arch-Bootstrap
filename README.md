# Arch-Bootstrap
My own Arch bootstrap script, including postinstall. Should work out of the box from Fedora 30 and newer and LVM partitions.

## preparation
- make sure to backup any data you want to keep, managing partitions can be tricky.
- Optional: from Fedora run ```dnf install -y blivet-gui```

## clone this repository

```git clone https://github.com/TesterTech/Arch-Bootstrap.git && cd Arch-Bootstrap```

# Adjust script parameters if needed
- These parameters can be adjusted based on what you want. Keep in mind that LVM_PARTITION could be different on your machine based on the choice of your partition.
```
ARCH_VERSION=2020.06.01
LVM_PARTITION=rhel-arch--root
```

## run the get-arch-bootstrap.sh script 
- The script asks for your password because of sudo
```./get-arch-bootstrap.sh```
- Remember to set the root password in this step
- Once script is done, install any additional software you want using pacman

## Run the postinstall script
- Some settings for postinstall:
  - Download the mkinitcpio.conf file to /etc/mkinitcpio.conf note: the i915 and lvm2 changed (change these modules if you want other KMS settings. 
  - Download the 40_custom file to /etc/grub.d/40_custom
  - Run the Grub command grub2-mkconfig to consolidate the Grub config 

## Important manual step!
- Open a new terminal and run the following command to write the fstab to the chrooted env. 
```sudo genfstab  -U / >> /mnt/archroot/etc/fstab```
- Go back to the still running chroot session and change the just created file fstab in /etc 
  - Make the following change change the mounted partition (/mnt/archroot) to / 
  - Keep /home /boot and /boot/efi as they are
  - Remove unneeded Fedora root partition from the file

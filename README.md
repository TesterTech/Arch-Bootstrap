# Arch-Bootstrap
My own Arch bootstrap script, including postinstall. Should work out of the box from Fedora 30 and newer and a running system using:
- LVM partitions
- UEFI boot
- One nvme SSD
- Intel Graphics

## preparation
- make sure to backup any data you want to keep, managing partitions can be tricky.
- Recommended: from Fedora run ```dnf install -y blivet-gui```

## clone this repository

```git clone https://github.com/TesterTech/Arch-Bootstrap.git && cd Arch-Bootstrap```

# Adjust script parameters if needed
- These parameters can be adjusted based on what you want. Keep in mind that LVM_PARTITION could be different on your machine based on the choice of your partition.
- To check the LVM_PARTITION run ```ls -l /dev/mapper```
```
ARCH_VERSION=2020.06.01
LVM_PARTITION=rhel-arch--root
```

## Run the get-arch-bootstrap.sh script 
- Run ```./get-arch-bootstrap.sh```
- The script asks for your password because of sudo

## Run the postinstall script
- Set the root password
- Validate mkinitcpio and fstab.auto files
- Edit the fstab.auto to:  
  - Keep /home /boot and /boot/efi as they are
  - Remove unneeded Fedora root partition from the file
  - Change /mnt/archroot to /
- Once script is done, install any additional software you want using pacman

## Exit Arch-chroot (Control + d) 
- Download the 40_custom file to /etc/grub.d/40_custom
- Run the Grub command ```sudo grub2-mkconfig -o "$(readlink -e /etc/grub2-efi.cfg)"``` to consolidate the Grub config 
- Reboot

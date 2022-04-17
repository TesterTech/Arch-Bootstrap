# Arch-Bootstrap

## preparation
- make sure to backup any data you want to keep, managing partitions can be tricky.

## clone this repository

```git clone --branch ubuntu https://github.com/TesterTech/Arch-Bootstrap.git && cd Arch-Bootstrap```

## Run the get-arch-bootstrap.sh script 
- Check if the below script has the right parameters
- Run ```./get-arch-bootstrap.sh```
- The script asks for your password because of sudo

## Run the postinstall script
- Set the root password
- Validate mkinitcpio and fstab files
- Edit the fstab.auto to:  
  - Keep /home /boot as they are
  - Remove unneeded root partition from the file
  - Change /opt to /
- Once script is done, install any additional software you want using pacman

## Exit Arch-chroot (Control + d) 
- Run the Grub command ```sudo grub-mkconfig -o /etc/grub.d/grub.cfg``` to consolidate the Grub config 
- Reboot

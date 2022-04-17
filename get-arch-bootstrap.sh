#!/bin/bash
PARTITION=/dev/sda6 # <-- ! change this to your own partition !
MOUNT_POINT=/opt

sudo mount $PARTITION $MOUNT_POINT

echo "Note: automatic fstab in /etc/fstab.auto be sure to change!"
sudo genfstab  -U / > /tmp/fstab.auto
sudo cp /tmp/fstab.auto $MOUNT_POINT/etc/fstab.auto

sudo grub-editenv - set menu_show_once=1
cd /tmp

echo "Download the postinstall and copy to ${MOUNT_POINT}"
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/master/arch-postinstall.sh' -o arch-postinstall.sh
sudo chmod +x arch-postinstall.sh
sudo cp ./arch-postinstall.sh $MOUNT_POINT
echo "Note: don't forget to run the postinstall from the /opt dir."

sudo arch-chroot $MOUNT_POINT

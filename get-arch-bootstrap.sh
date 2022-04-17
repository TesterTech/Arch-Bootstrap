#!/bin/bash
PARTITION=/dev/sda6 # <-- ! change this to your own partition !
MOUNT_POINT=/opt
sudo mount $PARTITION $MOUNT_POINT

sudo apt install -y git vim openssh-server curl zstd arch-install-scripts
wget https://raw.githubusercontent.com/TesterTech/arch-bootstrap-from-ubuntu/master/arch-bootstrap.sh
wget https://raw.githubusercontent.com/TesterTech/arch-bootstrap-from-ubuntu/master/get-pacman-dependencies.sh
install -m 755 arch-bootstrap.sh /usr/local/bin/arch-bootstrap

echo "Note:"
echo "Automatic fstab in /etc/fstab make sure to change to real config"
cd /tmp
sudo genfstab  -U / > /tmp/fstab
sudo cp -f /tmp/fstab $MOUNT_POINT/etc/fstab
sudo grub-editenv - set menu_show_once=1

echo "Download the postinstall and copy to ${MOUNT_POINT}"
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/ubuntu/arch-postinstall.sh' -o postinstall.sh
sudo chmod +x postinstall.sh
sudo cp ./postinstall.sh $MOUNT_POINT
echo "Note: don't forget to run the postinstall from the /opt dir."

sudo arch-chroot $MOUNT_POINT

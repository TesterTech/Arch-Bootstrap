#!/bin/bash
# Automatic bootstrap script for Arch Linux when you want to install it from Fedora
# - Automatic fstab in /etc/fstab.auto (in your arch-chroot env.) be sure to change!
# - Don't forget to run the postinstall-script from the /opt dir!
# - Note that the mirror (nlrtm1-edge1.cdn.i3d.net) is good for me (Netherlands) 
#   but doesn't have to be the best one for you, check https://wiki.archlinux.org/index.php/Mirrors
ARCH_VERSION=2020.06.01
LVM_PARTITION=rhel-arch--root
MOUNT_POINT=/mnt/archroot

export PACSTRAP=true #can be set to false if you already have pac-strapped your system
export BOOTSTRAP_PREP=true #can be set to false if you don't need a new chroot environment

echo "Mount ${LVM_PARTITION} to mount point ${MOUNT_POINT}"
if [[ ! -d $MOUNT_POINT ]];
    echo "The dir ${MOUNT_POINT} does not exist, create it. "
    then sudo mkdir $MOUNT_POINT
fi
sudo mount /dev/mapper/$LVM_PARTITION $MOUNT_POINT

if ($PACSTRAP); then
    # https://wiki.archlinux.org/index.php/Install_Arch_Linux_from_existing_Linux
    echo "Pacstrap - install Fedora pre-requisites (pacman and arch install scripts)"
    sudo dnf install -y pacman arch-install-scripts
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacstrap /mnt/archroot base vim nano #put nano in there as well for non-vim users :-)
    echo "Note: automatic fstab in /etc/fstab.auto be sure to change!"
    sudo genfstab  -U / > /tmp/fstab.auto
    sudo cp /tmp/fstab.auto /mnt/archroot/etc/fstab.auto
fi

if ($BOOTSTRAP_PREP); then
    cd /tmp
    echo "Bootstrap prep - get the bootstrap and chroot into there /tmp/root.x86_64/) "
    if [[ ! -f archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig ]]; then 
        echo "download sig file"
        wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
    fi
    if [[ ! -f archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz ]]; then
        echo "download bootstrap tar.gz"
        wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz
    fi
    gpg --keyserver-options auto-key-retrieve --verify archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
    echo "extract the archive"
    sudo tar xzf archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz 
fi

sudo grub2-editenv - set menu_show_once=1
cd /tmp

echo "Download the postinstall and copy to ${MOUNT_POINT}/opt "
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/master/arch-postinstall.sh' -o arch-postinstall.sh
sudo chmod +x arch-postinstall.sh
sudo cp ./arch-postinstall.sh $MOUNT_POINT/opt
echo "Note: don't forget to run the postinstall from the /opt dir."
echo "arch-chroot into ${MOUNT_POINT}"
sudo ./root.x86_64/bin/arch-chroot $MOUNT_POINT

#To add the menu entry, from Fedora run: sudo vim /etc/grub.d/40_custom and add below:
#menuentry 'Arch Linux' {
#    linuxefi (lvm/rhel-arch--root)/boot/vmlinuz-linux-lts root=/dev/mapper/rhel-arch--root rd.lvm.lv=rhel/rhel-arch--root
#    initrdefi (lvm/rhel-arch--root)/boot/initramfs-lts-linux.img
#}

# Added a line in the postinstall script to set the rootpassword (so you won't forget like me ;-))

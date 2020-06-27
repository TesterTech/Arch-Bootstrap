#!/bin/bash
ARCH_VERSION=2020.06.01
LVM_PARTITION=rhel-arch--root
MOUNT_POINT=/mnt/archroot

export PACSTRAP=false
export BOOTSTRAP_PREP=true

echo "Mount ${LVM_PARTITION} to mount point ${MOUNT_POINT}"
if [[ ! -d /mnt/archroot ]];
    echo "The dir ${MOUNT_POINT} does not exist, create it. "
    then sudo mkdir /mnt/archroot
fi
sudo mount /dev/mapper/$LVM_PARTITION $MOUNT_POINT

if ($PACSTRAP); then
    # https://wiki.archlinux.org/index.php/Install_Arch_Linux_from_existing_Linux
    echo "Install Fedora pre-requisites (pacman and arch install scripts)"
    sudo dnf install -y pacman arch-install-scripts
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacstrap /mnt/archroot base linux-lts linux-lts-headers
    sudo genfstab  -U / >> /tmp/fstab.auto
    sudo cp /tmp/fstab.auto /mnt/archroot/etc/fstab.auto
    echo "Note: automatic fstab in /etc/fstab.auto be sure to change!"
fi

if ($BOOTSTRAP_PREP); then
    cd /tmp
    echo "get the bootstrap and chroot into there /tmp/root.x86_64/) "

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
echo "Note: don't forget to run the postinstall from the /opt dir."
curl 'https://raw.githubusercontent.com/TesterTech/Arch-Bootstrap/master/arch-postinstall.sh' -o arch-postinstall.sh
sudo chmod +x arch-postinstall.sh
sudo cp ./arch-postinstall.sh ./root.x86_64/opt/
echo "arch-chroot into ${MOUNT_POINT}"
sudo ./root.x86_64/bin/arch-chroot /mnt/archroot/

# From the chroot environment adjust the Kernel Mode Settings
# Add the required drivers there, in my case:
# intel drivers / lvm2 
# vim /etc/mkinitcpio.conf 
# add i915 for intel graphics and add lvm2 in the hooks

#sudo vim /etc/grub.d/40_custom
#menuentry 'Arch Linux' {
#    linuxefi (lvm/rhel-arch--root)/boot/vmlinuz-linux-lts root=/dev/mapper/rhel-arch--root rd.lvm.lv=rhel/rhel-arch--root
#    initrdefi (lvm/rhel-arch--root)/boot/initramfs-lts-linux.img
#}

# rootpassword / addusers
# from Fedora 
# /fstab 

# yay 
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si

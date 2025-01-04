#!/bin/bash
cloudinit_iso_name=`date +"%Y%m%d%I%M%S"`

# nameをユーザーに入力させる
read -p "Enter the name for the virtual machine: " name

# ディスクのコピーとサイズ変更
cp --sparse=always /var/lib/libvirt/iso/ubuntu-20.04-server-cloudimg-amd64.img /var/lib/libvirt/images/${name}.img
qemu-img resize /var/lib/libvirt/images/${name}.img 10G
#cloudinitファイルを作成
genisoimage -output ${cloudinit_iso_name}.iso -volid cidata -joliet -rock ./user-data ./meta-data

# virt-install コマンドの実行
sudo virt-install \
--name ${name} \
--ram 2048 \
--vcpus 2 \
--arch x86_64 \
--hvm \
--virt-type kvm \
--disk path=/var/lib/libvirt/images/${name}.img,size=10,device=disk,bus=virtio,format=qcow2  \
--cdrom ./${cloudinit_iso_name}.iso \
--boot hd \
--network bridge=br0 \
--graphics none \
--serial pty \
--console pty \
--noreboot \
--noautoconsole \
--os-variant ubuntu20.04

# isoファイルを削除
sudo rm -f ./${cloudinit_iso_name}.iso
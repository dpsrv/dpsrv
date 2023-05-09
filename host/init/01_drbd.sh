#!/bin/ash -ex

apk add drbd lsblk

DATA_IMG=${DATA_IMG:-/var/dpsrv/data.img}

if [ ! -f $DATA_IMG ]; then
    dd if=/dev/zero of=$DATA_IMG bs=100M count=1
fi

DATA_DEV=$(losetup -a | grep $DATA_IMG\$ | cut -d: -f1)
if [ -z "$DATA_DEV" ]; then
	losetup -Pf $DATA_IMG
	DATA_DEV=$(losetup -a | grep $DATA_IMG\$ | cut -d: -f1)
fi


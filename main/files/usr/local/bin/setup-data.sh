#!/bin/ash -x

DATA_IMG=${DATA_IMG:-/mnt/host/data.img}
DATA_MNT=${DATA_MNT:-/mnt/data}

if [ ! -f $DATA_IMG ]; then
	dd if=/dev/zero of=$DATA_IMG bs=1G count=1
fi

losetup -a | grep -q ^$DPSRV_DEV_LOOP || losetup -P $DPSRV_DEV_LOOP $DATA_IMG

exit 0

if ! file $DATA_IMG | grep -q ext4; then
	mkfs.ext4 $DATA_IMG
fi


[ -d $DATA_MNT ] || mkdir $DATA_MNT
mount -o loop $DPSRV_DEV_LOOP $DATA_MNT


#!/bin/ash -x

ls /etc/ssh/ssh_host_*key* > /dev/null || ssh-keygen -A

/usr/sbin/sshd -D &

DATA_IMG=/mnt/host/data.img
if [ ! -f $DATA_IMG ]; then
	dd if=/dev/zero of=$DATA_IMG bs=1G count=1
fi

if ! file $DATA_IMG | grep -q ext4; then
	mkfs.ext4 $DATA_IMG
fi

losetup -a | grep -q ^$DPSRV_DEV_LOOP || losetup -P $DPSRV_DEV_LOOP $DATA_IMG

DATA_MNT=/mnt/data

[ -d $DATA_MNT ] || mkdir $DATA_MNT
mount -o loop $DPSRV_DEV_LOOP $DATA_MNT

wait -n
rc=$?

echo "Exit $rc"



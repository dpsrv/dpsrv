#!/bin/ash -x

ls /etc/ssh/ssh_host_*key* > /dev/null || ssh-keygen -A

/usr/sbin/sshd -D &

DATA_IMG=/mnt/data/data.img
if [ -z $DATA_IMG ]; then
	dd if=/dev/zero of=$DATA_IMG bs=1G count=1
fi

if ! file $DATA_IMG | grep -q ext4; then
	mkfs.ext4 $DATA_IMG
fi

wait -n
rc=$?

echo "Exit $rc"



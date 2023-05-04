#!/bin/ash -x

ls /etc/ssh/ssh_host_*key* > /dev/null || ssh-keygen -A

/usr/sbin/sshd -D &

if [ -z /mnt/data/data.img ]; then
	dd if=/dev/zero of=/mnt/data/data.img bs=10G count=1
fi

wait -n
rc=$?

echo "Exit $rc"



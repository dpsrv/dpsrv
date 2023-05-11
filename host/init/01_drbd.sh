#!/bin/ash -ex

apk add drbd lsblk

DRBD_IMG=${DRBD_IMG:-/vagrant/.vagrant/drbd.img}

if [ ! -f $DRBD_IMG ]; then
	dd if=/dev/zero of=$DRBD_IMG bs=100M count=1 
fi

DRBD_LOOP_DEV=$(losetup -a | grep $DRBD_IMG\$ | cut -d: -f1)
if [ -z "$DRBD_LOOP_DEV" ]; then
	losetup -Pf $DRBD_IMG
	DRBD_LOOP_DEV=$(losetup -a | grep $DRBD_IMG\$ | cut -d: -f1)
fi

DRBD_DEV=/dev/drbd0

if [ ! -f /vagrant/.vagrant/drbd.res ]; then

	hostname=$(hostname)
	DRBD_ADDRS=${DPSRV_DRBD_ADDRS:-$hostname:7789 localhost:7789}

	export DRBD_DOMAINS=$(
		i=0
		for addr in $DRBD_ADDRS; do
			host=${addr%:*}
			port=${addr#*:}
			if [ "$host" = "$hostname" ]; then
				ipv4=$(ifconfig eth0 | grep 'inet addr:' |cut -d: -f2|awk '{ print $1 }')
			else
				ipv4=$(getent ahostsv4 $host|awk '{ print $1 }'|sort -fu)
			fi
	
			cat <<_EOT_
	on $host {
		address $ipv4:$port;
	}
_EOT_
			i=$(( i + 1 ))
		done
	)

cat <<_EOT_> /vagrant/.vagrant/drbd.res
resource drbd {
	device minor 0;
	disk $DRBD_LOOP_DEV;
	meta-disk internal;
	protocol A;
 
$DRBD_DOMAINS
}
_EOT_

	cp /vagrant/.vagrant/drbd.res /etc/drbd.d/drbd.res
	drbdadm -v create-md drbd
	drbdadm -v up drbd
	drbdadm -v primary drbd --force
else
	cp /vagrant/.vagrant/drbd.res /etc/drbd.d/drbd.res
	drbdadm -v up drbd
	drbdadm -v primary drbd
fi

if [ $(blkid -o value -s TYPE $DRBD_DEV) != "ext4" ]; then
   	mkfs.ext4 $DRBD_DEV
fi

DRBD_MNT=/mnt/drbd
mkdir -p $DRBD_MNT
mount $DRBD_DEV $DRBD_MNT

#!/bin/ash -ex

apk add drbd lsblk

DRBD_IMG=${DRBD_IMG:-/vagrant/.vagrant/drbd.img}

if [ ! -f $DRBD_IMG ]; then
	dd if=/dev/zero of=$DRBD_IMG bs=100M count=1
fi

DRBD_DEV=$(losetup -a | grep $DRBD_IMG\$ | cut -d: -f1)
if [ -z "$DRBD_DEV" ]; then
	losetup -Pf $DRBD_IMG
	DRBD_DEV=$(losetup -a | grep $DRBD_IMG\$ | cut -d: -f1)
fi

DRBD_ADDRS=${DPSRV_DRBD_ADDRS:-localhost:7789}

export DRBD_DOMAINS=$(
	i=0
	for addr in $DRBD_ADDRS; do
		host=${addr%:*}
		port=${addr#*:}
		ipv4=$(getent ahostsv4 $host|awk '{ print $1 }'|sort -fu)
	
		cat <<_EOT_
	on $host {
		address $ipv4:$port;
	}
_EOT_
		i=$(( i + 1 ))
	done
)

cat <<_EOT_> /etc/drbd.d/drbd.res
resource drbd {
	device minor 0;
	disk $DRBD_DEV;
	meta-disk internal;
	protocol A;
 
$DRBD_DOMAINS
}
_EOT_
   

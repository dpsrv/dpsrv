#!/bin/ash -x

cd $(dirname $0)
SD=$PWD
cd $OLDPWD

hostname $DPSRV_HOSTNAME

ls /etc/ssh/ssh_host_*key* > /dev/null || ssh-keygen -A

/usr/sbin/sshd -D &

. $SD/setup-drbd-domains.sh
$SD/render-templates.sh
$SD/setup-data.sh
$SD/setup-drbd.sh



wait -n
rc=$?

echo "Exit $rc"



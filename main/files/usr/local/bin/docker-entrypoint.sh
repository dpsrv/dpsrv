#!/bin/ash -x

cd $(dirname $0)
SD=$PWD
cd $OLDPWD

ls /etc/ssh/ssh_host_*key* > /dev/null || ssh-keygen -A

/usr/sbin/sshd -D &

$SD/render-templates.sh
$SD/setup-data.sh



wait -n
rc=$?

echo "Exit $rc"



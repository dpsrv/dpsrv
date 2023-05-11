#!/bin/ash -ex

apk add add nfs-utils

[ -d /vagrant/.vagrant/nfs ] || mkdir /vagrant/.vagrant/nfs

cat <<_EOT_>> /etc/exports
/vagrant/.vagrant/nfs *(rw,sync,no_root_squash,no_subtree_check)
_EOT_

rc-update add nfs
rc-service nfs start



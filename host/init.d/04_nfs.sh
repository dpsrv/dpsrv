#!/bin/ash -ex

grep " nfs " /etc/mtab >> /etc/fstab

rc-update add netmount


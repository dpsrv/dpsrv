#!/bin/ash -ex

/usr/local/bin/git_rc_init.sh 

named -c /etc/bind/named.conf -g -u named

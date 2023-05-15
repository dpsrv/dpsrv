#!/bin/ash -ex

named -c /etc/bind/named.conf -g -u named

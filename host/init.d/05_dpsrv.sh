#!/bin/ash -ex

apk add git
sudo -u docker ash -c 'mkdir projects && cd projects && git clone https://github.com/dpsrv/rc.git'

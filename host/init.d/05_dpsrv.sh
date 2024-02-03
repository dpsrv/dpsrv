#!/bin/ash -ex

apk add git
mkdir $HOME/projects
cd $HOME/projects
git clone https://github.com/dpsrv/rc.git
cd -

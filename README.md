# dpsrv

Distributed Personal Server  

The goal for this project is to setup multiple personal servers in different locations that provide redundancy for applications through mirroring and replication where appropriate.  

> Intended to run on Mac 

## Host setup

### Docker

#### Desktop
The easiest way to install docker on your Mac, but will not start at boot.  
https://docs.docker.com/desktop/install/mac-install/

#### Machine
A bit more sophisticated, but allows to run containers at boot.  
https://github.com/docker/machine

### Devices
#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

# dpsrv

Distributed Personal Server  

The goal for this project is to setup multiple personal servers in different locations that provide redundancy for applications through mirroring and replication where appropriate.  

> I built it for Mac, but it may work on other systems.  

## Host setup

### VirtualBox
Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).  
Make it run at startup:
```bash
sudo cp \
    /Applications/VirtualBox.app/Contents/MacOS/org.virtualbox.vboxautostart.plist \
    /Library/LaunchDaemons/

sudo plutil -replace Disabled -bool false /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist

sudo plutil -replace KeepAlive -bool true /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist

[ -d /etc/vbox ] || sudo mkdir /etc/vbox
[ -f /etc/vbox/autostart.cfg ] || sudo tee /etc/vbox/autostart.cfg <<_EOT_ >/dev/null
default_policy = deny
$LOGNAME = {
	allow = true
}
_EOT_

sudo chmod a+x /Applications/VirtualBox.app/Contents/MacOS/VBoxAutostartDarwin.sh

sudo launchctl load -w /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist

```

#### Machine
A bit more sophisticated, but allows to run containers at boot.  
https://github.com/docker/machine


### Devices
docker plugin install linbit/linstor-docker-volume --grant-all-permissions

#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

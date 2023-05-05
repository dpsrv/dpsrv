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

At which point you may need to go to `Settings > Privacy & Security`, scroll down and Allow updates by Oracle.  

#### docker-machine
Download and install docker-machine:
```bash
sudo curl -o /usr/local/bin/docker-machine -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-$(uname -s)-$(uname -m)
sudo chmod a+x /usr/local/bin/docker-machine"

VM_NAME=docker
docker-machine create -d virtualbox $VM_NAME || (
	[ -d $HOME/.docker/machine/cache ] || mkdir -p $HOME/.docker/machine/cache
	cd $HOME/.docker/machine/cache
	sudo curl -OL https://github.com/boot2docker/boot2docker/releases/download/v19.03.12/boot2docker.iso
	cd $OLDPWD
	docker-machine create -d virtualbox $VM_NAME
)

VBoxManage modifyvm $VM_NAME --autostart-enabled on
VBoxManage modifyvm $VM_NAME --autostop-type acpishutdown
```


### Devices
docker plugin install linbit/linstor-docker-volume --grant-all-permissions

#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

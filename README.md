# dpsrv

Distributed Personal Server  

The goal for this project is to setup multiple personal servers in different locations that provide redundancy for applications through mirroring and replication where appropriate.  

> I built it for Mac, but it may work on other systems.  

## Host setup

### VirtualBox
> Used to run Linux. Needed for containers.  

Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).  

Make it run at startup:
```bash
sudo cp \
	/Applications/VirtualBox.app/Contents/MacOS/org.virtualbox.vboxautostart.plist \
	/Library/LaunchDaemons/

sudo plutil -replace Disabled -bool false /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist

[ -d /etc/vbox ] || sudo mkdir /etc/vbox
[ -f /etc/vbox/autostart.cfg ] || sudo tee /etc/vbox/autostart.cfg <<_EOT_ >/dev/null
default_policy = deny
$USER = {
	allow = true
}
_EOT_

sudo chmod a+x /Applications/VirtualBox.app/Contents/MacOS/VBoxAutostartDarwin.sh

sudo launchctl load /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist
```

At which point you may need to go to `Settings > Privacy & Security`, scroll down and Allow updates by Oracle.  

### Vagrant
> Used to download Linux images for VirtualBox.  

Download and install [Vagrant](https://developer.hashicorp.com/vagrant/downloads).  

Setup Linux and make it start on boot:
```bash
vagrant up
vagrant ssh-config --host containerd >> $HOME/.ssh/config
```

### Docker
Configure location of the docker host:
```bash
export DOCKER_HOST=ssh://containerd
```

### Devices
docker plugin install linbit/linstor-docker-volume --grant-all-permissions

#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

# dpsrv

Distributed Personal Server  

The goal of this project is to setup multiple personal servers in different locations that provide redundancy for applications through mirroring and replication.  

> My instructions are for Mac, but they may work on other systems too.  

## Host setup

### VirtualBox
> Used to run the docker host. VirtualBox can start at Mac's boot, and thus so can containers. Docker Desktop is a user app and can't start at boot without some serious OSX specific shamanic dances.   

Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).  

Make VirtualBox run at boot:
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

At this point you may need to go to `Settings > Privacy & Security`, scroll down and Allow updates by Oracle.  
> I have not figured out yet how to do this from the shell. Ideas?

### Vagrant
> Used to download os images for VirtualBox.  

Download and install [Vagrant](https://developer.hashicorp.com/vagrant/downloads).  

Setup docker vm using provided Vagrantfile, and update ssh config:
```bash
vagrant up
vagrant ssh-config --host docker >> $HOME/.ssh/config
```

### Docker Desktop
> Used to build and deploy containers.  

Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop/).  

> You do not need to run it, as your host is already set up.

Configure location of the docker host:
```bash
export DOCKER_HOST=ssh://docker
```

At this point you should be able to use docker commands in a familiar manner.

### Devices
docker plugin install linbit/linstor-docker-volume --grant-all-permissions

#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

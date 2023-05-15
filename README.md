# Distributed Personal Server

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

At this point we may need to go to `Settings > Privacy & Security`, scroll down and Allow updates by Oracle.  
> I have not figured out yet how to do this from the shell. Ideas?

### Sensitive information
Some of the information that we may store in git may be sensetive, and we do not want others to have access to it. We'll keep that in directory called `secrets/` and we'll encrypt it using [git-openssl-secrets](https://github.com/maxfortun/git-openssl-secrets).

### Vagrant
> Used to download os images for VirtualBox.  

Download and install [Vagrant](https://developer.hashicorp.com/vagrant/downloads).  

Setup docker vm using provided [Vagrantfile](Vagrantfile), and update ssh config:
```bash
vagrant up
vagrant ssh-config --host docker >> $HOME/.ssh/config
```

### Docker Desktop
> Used to build and deploy containers.  

Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop/).  

> We do not need to run it, as our host is already set up.

Configure location of the docker host:
```bash
export DOCKER_HOST=ssh://docker
```

At this point we should be able to use docker commands in a familiar manner.

### DNS
While most do not think of it as such, DNS is the most ubiquitous distributed database on the internet.
And being itself distributed it is uniquely suited for being used to configure other distributed systems.
In our distributed system each server will run as a master and will dynamically generate its configuration files from shared storage[tbd]. 
The initial node does not need to be aware of any other nodes, however, when a new node wants to join a cluster it will need a hostname of a cluster's A record.

1. ionotifywait -r /var/dpsrv/etc/bind
2. combind /var/dpsrv/etc/bind > /etc/bind
3. kill -HUP bind

### Certbot

### Storage
We will need shared storage for our servers to keep their configuration in sync.  
> This is not intended to be used for application data. Only for the configuration.  

#### DRBD
ssh docker sudo apk add drbd lsblk e2fsprogs gettext
ssh docker sudo mkdir -p /var/dpsrv
ssh docker sudo dd if=/dev/zero of=/var/dpsrv/shared.img bs=100M count=1
ssh docker sudo 'losetup -a | grep /var/dpsrv/shared.img || losetup -Pf /var/dpsrv/shared.img'
ssh docker sudo 'file /var/dpsrv/shared.img | grep -q ext4 || sudo mkfs.ext4 /var/dpsrv/shared.img'
ssh docker sudo mkdir -p /mnt/dpsrv
ssh docker sudo 'mount -o loop $(sudo losetup -a | grep /var/dpsrv/shared.img|cut -d: -f0) /mnt/dpsrv'

#### Block 
```bash
export DPSRV_ROOT=.
dd if=/dev/zero of=$DPSRV_ROOT/mnt/data bs=1G count=10
hdiutil attach -imagekey diskimage-class=CRawDiskImage -nomount $DPSRV_ROOT/mnt/data 
```

$init = <<-SCRIPT
	sudo apk add docker
	sudo rc-update add docker
	sudo rc-service docker start

	sudo addgroup vagrant docker
	sudo sh -c 'while [ ! -e /var/run/docker/containerd/containerd.sock ]; do echo "Waiting for /var/run/docker/containerd/containerd.sock"; sleep 1; done'
	sudo chgrp docker /var/run/docker/containerd/containerd.sock
SCRIPT

Vagrant.configure("2") do |config|
	config.vm.box      = "generic/alpine317"
	config.vm.hostname = "docker"

	config.vm.define "docker"

	config.vm.provision "shell", inline: $init

	config.vm.provider "virtualbox" do |vb|
		vb.name = "docker"

		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

Vagrant.configure("2") do |config|
	config.vm.define "docker"

	config.vm.box      = "generic/alpine317"
	config.vm.hostname = "docker"

	config.vm.synced_folder ".", "/vagrant", disabled: false

	config.vm.provision "shell", inline: "/vagrant/host/init.sh"

	# DRBD
	config.vm.network "forwarded_port", host: 27788, guest: 7788
	# NFS
	config.vm.network "forwarded_port", host: 22049, guest: 2049

	# SSH/hadoop
	config.vm.network "forwarded_port", host: 2322, guest: 2322

	config.vm.provider "virtualbox" do |vb|
		vb.name = "docker"

		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

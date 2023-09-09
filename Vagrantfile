Vagrant.configure("2") do |config|
	config.vm.define "docker"

	config.vm.box		= "generic/alpine317"
	config.vm.hostname	= "docker"

	config.vm.synced_folder "/Users", 							"/Users"					, type: "nfs", nfs_udp: false
	config.vm.synced_folder "/Volumes",							"/Volumes"					, type: "nfs", nfs_udp: false
	config.vm.synced_folder ".",								"/vagrant"					, type: "nfs", nfs_udp: false		
	config.vm.synced_folder "#{Dir.home}/.config/git/dpsrv",	"/root/.config/git/dpsrv"	, type: "nfs", nfs_udp: false

	config.vm.provision "shell", inline: "/vagrant/host/init.sh"

	config.vm.network "private_network", type: "dhcp"

	for i in 50000..51000
		config.vm.network :forwarded_port, guest: i, host: i
	end

	config.vm.provider "virtualbox" do |vb|
		vb.name	= "docker"

		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

Vagrant.configure("2") do |config|
	config.vm.define "docker"

	config.vm.box      = "generic/alpine317"
	config.vm.hostname = "docker"

	config.vm.synced_folder ".", "/vagrant", disabled: false

	config.vm.provision "shell", inline: "/vagrant/host/init.sh"

	config.vm.network "forwarded_port", guest: 7789, host: 27789

	config.vm.provider "virtualbox" do |vb|
		vb.name = "docker"

		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

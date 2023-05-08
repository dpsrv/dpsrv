$init = <<-SCRIPT
	sudo apk add dockerd

	sudo rc-update add docker-engine
	sudo rc-service docker-engine start
SCRIPT

Vagrant.configure("2") do |config|
	config.vm.box = "generic/alpine317"

	config.vm.hostname = "docker"

	config.vm.provision "shell", inline: $init

	config.vm.provider "virtualbox" do |vb|
		vb.name = "docker"
		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

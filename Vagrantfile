$install_containerd = <<-SCRIPT
	sudo apk add containerd

	sudo mkdir -p /etc/containerd/certs

	sudo openssl req -x509 \
		-sha256 -days 356 \
		-nodes \
		-newkey rsa:2048 \
		-subj "/CN=containerd/C=US/L=Containers" \
		-keyout /etc/containerd/certs/containerdCA.key -out /etc/containerd/certs/containerdCA.crt 

	sudo sed -i 's#tcp_address = ""#tcp_address = "0.0.0.0:2376"#' /etc/containerd/config.toml
	sudo sed -i 's#tcp_tls_ca = ""#tcp_tls_ca = "/etc/containerd/certs/containerdCA.crt"#' /etc/containerd/config.toml
	sudo sed -i 's#tcp_tls_cert = ""#tcp_tls_cert = "/etc/containerd/certs/containerdCA.crt"#' /etc/containerd/config.toml
	sudo sed -i 's#tcp_tls_key = ""#tcp_tls_key = "/etc/containerd/certs/containerdCA.key"#' /etc/containerd/config.toml

	sudo rc-update add containerd
	sudo rc-service containerd start
SCRIPT

Vagrant.configure("2") do |config|
	config.vm.box = "generic/alpine317"

	config.vm.hostname = "containerd"

	config.vm.provision "shell", inline: $install_containerd

	config.vm.provider "virtualbox" do |vb|
		vb.name = "containerd"
		vb.customize ["modifyvm", :id, "--autostart-enabled", "on"]
		vb.customize ["modifyvm", :id, "--autostop-type", "acpishutdown"]
	end
end

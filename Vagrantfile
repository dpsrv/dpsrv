Vagrant.configure('2') do |config|
	config.vm.define 'docker'

	config.vm.box		= 'generic/alpine317'
	config.vm.hostname	= 'docker'

	config.vm.synced_folder '/Users', 							'/Users'					, type: 'nfs', nfs_udp: false
	config.vm.synced_folder '.',								'/vagrant'					, type: 'nfs', nfs_udp: false		
	config.vm.synced_folder "#{Dir.home}/.config/git/dpsrv",	'/root/.config/git/dpsrv'	, type: 'nfs', nfs_udp: false

	Dir.entries('/Volumes/').each do |entry|
		dir = "/Volumes/#{entry}"
		stat = File.stat(dir)
		next if entry == ".." || entry == "." || not(File.directory? dir) || stat.uid != 0
		config.vm.synced_folder dir, dir, type: 'nfs', nfs_udp: false, mount_options: [ 'nolock' ]
	end

	config.vm.provision 'shell', inline: '/vagrant/host/init.sh'

	config.vm.network 'private_network', type: 'dhcp'

	for i in 50000..51000
		config.vm.network :forwarded_port, guest: i, host: i
	end

	config.vm.provider 'virtualbox' do |vb|
		vb.name		= 'docker'

		vb.memory	= 4096
		vb.cpus		= 2

		vb.customize ['modifyvm', :id, '--autostart-enabled', 'on']
		vb.customize ['modifyvm', :id, '--autostop-type', 'acpishutdown']
		vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
	end
end


Vagrant.configure('2') do |config|
	config.vm.define 'docker'

	config.vm.box		= 'generic/alpine318'
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

	wifiBridge=`networksetup -listallhardwareports | grep -A 1 Wi-Fi | sed 's/^[^:]*: //g' | nl | sort -nr | cut -f2- | paste - - | sed $'s/[\s\t][\s\t]*/: /' | tr -d '\n'`
	config.vm.network 'public_network', bridge: [ wifiBridge ]

	#for i in 50000..51000
		#config.vm.network :forwarded_port, guest: i, host: i, protocol: 'tcp'
		#config.vm.network :forwarded_port, guest: i, host: i, protocol: 'udp'
	#end

	config.vm.provider 'virtualbox' do |vb|
		vb.name		= 'docker'

		vb.memory	= 2048
		vb.cpus		= 1

		vb.customize ['modifyvm', :id, '--autostart-enabled', 'on']
		vb.customize ['modifyvm', :id, '--autostop-type', 'acpishutdown']
		vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
	end
end

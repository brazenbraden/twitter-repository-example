Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.box_check_update = false
  config.vm.network :private_network, ip: '10.0.0.123'
  config.vm.synced_folder '.', '/app', type: 'nfs', mount_options: ['nolock,vers=3,udp,noatime']

  config.vm.provider :virtualbox do |v|
    v.name = 'twitter'
    v.check_guest_additions = false
    v.gui = false
    v.memory = 2048
    v.cpus = 1
  end

  config.vbguest.auto_update = false if Vagrant.has_plugin?('vagrant-vbguest')
  unless Vagrant.has_plugin?('vagrant-docker-compose')
    raise 'vagrant-docker-compose is not installed! Please run: vagrant plugin install vagrant-docker-compose'
  end

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: '/app/docker-compose.yml', run: 'always'#, rebuild: true
end

Vagrant.configure("2") do |config|
  config.vm.box = "dhc-ubuntu-14.04.1"
  config.vm.box_url = "https://objects.dreamhost.com/public-github/vagrant/boxes/dhc-ubuntu-14.04.1-v1.0.box"
  config.ssh.private_key_path = "~/.ssh/bootstrap"

  config.vm.define :cookbook do |node|
    node.vm.hostname = "dhcapps"
    node.vm.provider :libvirt do |domain|
      domain.driver = 'kvm'
      domain.cpus = 1
      domain.memory = 1024
      domain.cpu_mode = 'host-passthrough'
    end
  end

  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "./"
    chef.add_recipe "#{ENV['DHCAPPS_RECIPE']}"
  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :rabbit1 do |rabbit1_config|
    rabbit1_config.vm.box = "deimosfr/debian-wheezy"
    rabbit1_config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "rabbit.pp"
    end
    rabbit1_config.vm.network :hostonly, "192.168.1.10"
    rabbit1_config.vm.host_name = "rabbit1"
  end
  config.vm.define :rabbit2 do |rabbit2_config|
    rabbit2_config.vm.box = "deimosfr/debian-wheezy"
    rabbit2_config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "rabbit.pp"
    end
    rabbit2_config.vm.network :hostonly, "192.168.1.11"
    rabbit2_config.vm.host_name = "rabbit2"
  end

end
#puppet apply --manifestdir /tmp/vagrant-puppet-1/manifests --detailed-exitcodes /tmp/vagrant-puppet-1/manifests/rabbit.pp

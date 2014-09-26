# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :rabbit1 do |rabbit1_config|
    rabbit1_config.vm.box = "puppetlabs/debian-7.4-64-puppet"
    rabbit1_config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "rabbit.pp"
    end
    rabbit1_config.vm.network :hostonly, "192.168.1.10"
  end
  #config.vm.define :rabbit1 do |rabbit1_config|
  #  rabbit1_config.vm.box = "puppetlabs/debian-7.4-64-puppet"
  #  rabbit1_config.vm.provision :puppet do |puppet|
  #    puppet.manifest_file = "rabbit.pp"
  #  end
  #  rabbit1_config.vm.network :hostonly, "192.168.1.10"
  #end

end

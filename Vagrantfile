# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #config.vm.box = "centos-64-x64-vbox"
  #config.vm.box_url = "http://ideas-download:ideas-download@nexus.asv.local/content/repositories/ideas-releases-local/vagrant-boxes/centos-64-x64-vbox/1.0/centos-64-x64-vbox-1.0.box"
  config.vm.box = "centos65-x86_64"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140110.box"

  #config.vm.network :private_network, type: :dhcp
  config.vm.network :private_network, ip: "192.168.33.7"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", "2048"]
    v.customize ["modifyvm", :id, "--cpus", "1"]
  end

  config.berkshelf.enabled = true

  config.vm.provision :shell, inline: 'LC_ALL=C lokkit --disabled'

  config.vm.define :randshop do |v|
    v.vm.hostname = "vagrant-randshop"
    v.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks"]
      chef.add_recipe "randshop"
      chef.run_list = [
        "recipe[randshop]",
      ]
      chef.json = {
        'mysql' => {
          "server_root_password" => "iloverandompasswordsbutthiswilldo",
          "server_repl_password" => "iloverandompasswordsbutthiswilldo",
          "server_debian_password" => "iloverandompasswordsbutthiswilldo"
        }
      }

      chef.log_level = :debug
    end
  end
end

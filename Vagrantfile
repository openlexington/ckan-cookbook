# -*- mode: ruby -*-
# vi: set ft=ruby :

# TODO: use newer vagrant
#Vagrant.require_version ">= 1.5.0"

Vagrant.configure('2') do |config|
  config.vm.define('ckan') do |ckan|
    ckan.vm.hostname = 'ckan'
    ckan.vm.network :private_network, type: 'dhcp'

    ckan.vm.box = 'opscode_ubuntu-12.04_provisionerless'
    ckan.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'

    ckan.berkshelf.enabled = true
    ckan.omnibus.chef_version = '11.10.4'
    %w{apt chef gem}.each {|c| ckan.cache.enable c.to_sym}

    ckan.vm.provision :chef_solo do |chef|
      chef.json = {}
      chef.run_list = []
    end
  end
end

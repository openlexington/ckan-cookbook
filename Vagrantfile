# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.0"

Vagrant.configure('2') do |config|
  config.vm.define('ckan') do |ckan|
    ckan.vm.hostname = 'ckan'
    ckan.vm.network :forwarded_port, guest: 3000, host: 3000

    ckan.vm.provider 'virtualbox' do |v|
      v.name = 'ckan'
      v.memory = 2048
    end

    ckan.vm.box = 'opscode_ubuntu-12.04_provisionerless'
    ckan.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/' +
                      'vagrant/opscode_ubuntu-12.04_provisionerless.box'

    ckan.berkshelf.enabled = true
    ckan.omnibus.chef_version = '11.10.4'

    ckan.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = [
        'recipe[apt]',
        'recipe[annoyances]',
        'recipe[build-essential]',
        'recipe[sudo]',
        'recipe[hostname]',
        'recipe[ckan::default]',
        'recipe[ckan::vagrant-keys]'
      ]
      chef.json = {
        authorization: {
          sudo: {
            users: ['ubuntu','vagrant'],
            passwordless: true
          }
        },
        build_essential: {
          compile_time: true
        },
        postgresql: {
          version: '9.3',
          password: {postgres: 'password'},
          config: {
            ssl_cert_file: '/etc/ssl/certs/ssl-cert-snakeoil.pem',
            ssl_key_file: '/etc/ssl/private/ssl-cert-snakeoil.key'
          }
        }
      }
    end
  end
end

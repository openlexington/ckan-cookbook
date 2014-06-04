# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.5.3', '<= 1.5.4'

def cache config, name, guest_path
  require 'fileutils'
  require 'pathname'
  name = name.to_s
  local = File.join(File.expand_path('~/.vagrant.d/cache'), config.vm.box, name)
  FileUtils.mkdir_p local
  config.vm.synced_folder local, guest_path
end

Vagrant.configure('2') do |config|
  config.vm.define('ckan') do |ckan|
    ckan.vm.hostname = 'ckan'
    ckan.vm.box = 'opscode_ubuntu-12.04_provisionerless'
    ckan.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/' +
                      'vagrant/opscode_ubuntu-12.04_provisionerless.box'

    ckan.vm.provider 'virtualbox' do |v|
      v.name = 'ckan'
      v.memory = 2048
    end

    ckan.vm.network :forwarded_port, guest: 5000, host: 5000

    cache ckan, :apt, '/var/cache/apt/archives'
    cache ckan, :chef, '/var/chef/cache'
    cache ckan, :gem, '/var/lib/gems/2.1.0'

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

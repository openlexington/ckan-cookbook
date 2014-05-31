#
# Cookbook Name:: ckan
# Recipe:: vagrant-keys
#
# Copyright (C) 2014 Mike Dillion
#
# All rights reserved - Do Not Redistribute
#

cookbook_file 'vagrant insecure private key' do
  owner 'ckan'
  group 'ckan'
  mode 0600
  path '/home/ckan/.ssh/vagrant_insecure_private_key'
  source 'vagrant_insecure_private_key'
  action :create_if_missing
end

cookbook_file 'vagrant insecure public key' do
  owner 'ckan'
  group 'ckan'
  mode 0600
  path '/home/ckan/.ssh/vagrant_insecure_public_key'
  source 'vagrant_insecure_public_key'
  action :create_if_missing
end

# TODO: This should be accomplished via an LWRP that
# /doesn't/ require the source to be a databag
bash 'copy insecure key to authorized_keys' do
  cwd '/home/ckan/.ssh/'
  code 'cat vagrant_insecure_public_key >> authorized_keys'
  action :run
end

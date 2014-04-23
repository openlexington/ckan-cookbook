#
# Cookbook Name:: ckan
# Recipe:: default
#
# Copyright (C) 2014 Mike Dillion
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

group 'ckan' do
  action :create
end

user 'ckan' do
  gid 'ckan'
  shell '/bin/bash'
  home File.join('/home/', 'ckan')
  supports manage_home: true
  action :create
end

directory File.join('/home/', 'ckan', '.ssh') do
  owner 'ckan'
  group 'ckan'
  mode 0700
  action :create
end

cookbook_file 'vagrant insecure key' do
  owner 'ckan'
  group 'ckan'
  mode 0600
  path '/home/ckan/.ssh'
  source 'insecure_private_key'
  action :create_if_missing
end

directory '/opt/ckan' do
  owner 'ckan'
  group 'ckan'
  mode 0600
  action :create
end

git '/home/ckan/ckan' do
  repository node['ckan']['repo_url']
  revision node['ckan']['release']
  user 'ckan'
  group 'ckan'
  action :checkout
end

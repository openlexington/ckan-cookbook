#
# Cookbook Name:: ckan
# Recipe:: default
#
# Copyright (C) 2014 Mike Dillion
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'
include_recipe 'python'
include_recipe 'postgresql::ruby'
package 'libpq-dev'
include_recipe 'postgresql::server'
include_recipe 'postgresql::client'

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

postgresql_connection = {
  username: 'postgres',
  host: 'localhost'
}

postgresql_database_user 'ckan' do
  username 'ckan'
  password 'ckan'
  connection postgresql_connection
  action :create
end

postgresql_database 'ckan' do
  owner 'ckan'
  database_name 'ckan'
  connection postgresql_connection
  action :create
end

postgresql_database_user 'ckan' do
  username 'ckan'
  database_name 'ckan'
  privileges [:all]
  connection postgresql_connection
  action :grant
end

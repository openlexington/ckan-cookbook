#
# Cookbook Name:: ckan
# Recipe:: default
#
# Copyright (C) 2014 Mike Dillion
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'sudo'
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

group 'staff' do
  action :modify
  members 'ckan'
  append true
end

directory File.join('/home/', 'ckan', '.ssh') do
  owner 'ckan'
  group 'ckan'
  mode 0700
  action :create
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

postgresql_database_user 'ckan_default' do
  username 'ckan_default'
  password 'ckan_default'
  connection postgresql_connection
  action :create
end

postgresql_database 'ckan_default' do
  owner 'ckan_default'
  database_name 'ckan_default'
  connection postgresql_connection
  action :create
end

postgresql_database_user 'ckan_default' do
  username 'ckan_default'
  database_name 'ckan_default'
  privileges [:all]
  connection postgresql_connection
  action :grant
end

python_virtualenv '/usr/lib/ckan/default' do
  interpreter 'python2.7'
  owner 'ckan'
  group 'ckan'
  options '--no-site-packages'
  action :create
end

package 'python-pastescript' do
  action :install
end

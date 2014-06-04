#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright (C) 2014 Mike Dillion
#
# All rights reserved - Do Not Redistribute
#

node.set['solr']['version'] = '4.2.1'
node.set['solr']['checksum'] = '648a4b2509f6bcac83554ca5958cf607474e81f34e6ed3a0bc932ea7fac40b99'

node.set['jetty']['port'] = 8983
node.set['jetty']['version'] = '9.0.2.v20130417'
node.set['jetty']['link'] = 'http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.0.2.v20130417.tar.gz&r=1'
node.set['jetty']['checksum'] = '6ab0c0ba4ff98bfc7399a82a96a047fcd2161ae46622e36a3552ecf10b9cddb9'

include_recipe 'hipsnip-solr'

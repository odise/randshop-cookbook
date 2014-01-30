#
# Cookbook Name:: randshop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum-epel"
include_recipe "apache2"
#include_recipe "apache2::mod_php5"
#include_recipe "apache2::mod_rewrite"
#include_recipe "apache2::mod_auth_basic"

include_recipe "mysql::server"

%w{ php-mysql php-gd php-imap php-ldap php-mbstring 
php-odbc php-pear php-xml php-xmlrpc }.each do |pkg|
  package pkg
end

directory node['randshop']['phpinidir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

template "#{node['randshop']['phpinidir']}/php.ini" do
  source "randshop.php.ini.erb"
  mode 0440
  owner "root"
  group node['apache']['group']
end

web_app "randshop" do
  server_name node['hostname']
  server_aliases [node['fqdn'], node['server_name']]
  docroot node['randshop']['docroot']
  template 'randshop.apache.conf.erb'
  phpinidir node['randshop']['phpinidir']
end

package 'unzip'
package 'rsync'

ark 'randshop' do
  owner node['apache']['user']
  group node['apache']['group']
  url 'http://www.randshop.com/download/files/version_2_2.zip'
  prefix_root node['randshop']['installroot']
  prefix_home node['randshop']['installroot']
  checksum "f66be742a3748dcf124ca247b149c9f50f59adf92695932fa053707581f9a1a5"
  strip_leading_dir false
end

include_recipe "database::mysql"

# create connection info as an external ruby hash
mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database 'randshop' do
  connection    mysql_connection_info
  action :create
end

# Grant all privileges on all tables in foo db
mysql_database_user node['randshop']['database_user'] do
  connection    mysql_connection_info
  database_name node['randshop']['database_name']
  password node['randshop']['database_user_passwd']
  privileges    [:all]
  action        :grant
end

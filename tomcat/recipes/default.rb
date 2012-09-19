# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2012, Innovation District B.V.
#
package "tomcat7-user" do
  action  :install
end

directory node[:tomcat][:instance_dir] do
  action  :create    
end

directory node[:tomcat][:applications_dir] do
  action :create
end

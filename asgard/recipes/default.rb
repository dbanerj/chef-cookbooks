# Cookbook Name:: asgard
# Recipe:: default
#
# Copyright 2012, Innovation District B.V.
#
include_recipe "apache2::mod_proxy_http"

instance_war = "/opt/webapps/asgard.war"

remote_file instance_war do
  source "https://github.com/downloads/Netflix/asgard/asgard.war"
  mode "0644"
  action :create_if_missing
end

tomcat_webapp "asgard" do
  action        :create
  http_port     8080
  control_port  9090
  instance_memory "1024"

  war           instance_war
end

web_app "asgard" do
  server_name "localhost"
  template "apache-vhost.erb"
end

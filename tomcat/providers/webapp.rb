action :create do
  instance_dir  = "#{node[:tomcat][:instance_dir]}/#{new_resource.name}"
  instance_name = new_resource.name
  instance_user = new_resource.user || new_resource.name
  instance_group = new_resource.group || new_resource.name

  jdk_home = new_resource.jdk_home || "/usr/lib/jvm/java-1.7.0-openjdk-amd64"

  instance_war = "#{node[:tomcat][:applications_dir]}/#{new_resource.war}"

  template "/usr/local/bin/apache-tomcat7-instance-create" do
    source  "apache-tomcat7-instance-create.erb"
    cookbook "tomcat"
    mode    0755
    owner "root"
    group "root"
  end

  execute 'create Tomcat instance' do
    creates instance_dir
    command "apache-tomcat7-instance-create -p #{new_resource.http_port} -c #{new_resource.control_port} #{instance_dir}"
  end

  directory "#{instance_dir}/webapps/#{instance_name}" do
    action :nothing
    recursive true
  end

  service "tomcat-#{instance_name}" do
    action :nothing
  end

  group instance_group
  user instance_user do
    system  true
    home    "/home/#{instance_user}"
    gid     instance_group
    shell   "/bin/bash"
    supports  :manage_home => true
  end

  execute "chown -R #{instance_user}:#{instance_group} #{instance_dir}" do
    not_if "stat -c %U #{instance_dir}/webapps | grep #{instance_user}"
  end

  template "#{instance_dir}/conf/server.xml" do
    source "server.xml.erb"
    cookbook "tomcat"
    mode 0644
    owner instance_user
    group instance_group
    variables({
      :http_port => new_resource.http_port,
      :control_port => new_resource.control_port,
      :secure => new_resource.secure,
      :scheme => new_resource.scheme,
      :proxy_port => new_resource.proxy_port,
      :proxy_name => new_resource.proxy_name
    })
  end

  template "/etc/init.d/tomcat-#{instance_name}" do
    source "tomcat-init.erb"
    cookbook "tomcat"
    mode 0755
    owner "root"
    group "root"
    variables({
      :instance_name => instance_name,
      :instance_dir => instance_dir,
      :instance_user => instance_user,
      :instance_group => instance_group,
      :jdk_home => jdk_home,
      :java_opts => new_resource.java_opts,
      :java_opts_test => new_resource.java_opts_test,
      :java_opts_acc => new_resource.java_opts_acc,
      :java_opts_prod => new_resource.java_opts_prod,
      :jmx_port => new_resource.jmx_port
    })
  end

  link "#{instance_dir}/webapps/#{instance_name}.war" do
    to instance_war
    not_if "test #{instance_war} -ef #{instance_dir}/webapps/#{instance_name}.war"
    notifies :stop, "service[tomcat-#{instance_name}]"
    notifies :delete, "directory[#{instance_dir}/webapps/#{instance_name}]"
  end

  service "tomcat-#{instance_name}" do
    action  :enable
    supports :restart => true, :reload => true, :status => true
  end

  lib_dir  = "#{instance_dir}/lib"
  directory lib_dir do
    action :create
  end

end

action :create do
  instance_dir  = "#{node[:tomcat][:instance_dir]}/#{new_resource.name}"
  instance_name = new_resource.name
  instance_user = new_resource.user || new_resource.name
  instance_group = new_resource.group || new_resource.name

  jdk_home = new_resource.jdk_home || "/usr/lib/jvm/java-1.7.0-openjdk-amd64"

  instance_war = "#{node[:tomcat][:applications_dir]}/#{new_resource.war}"
  
  execute 'create Tomcat instance' do
    creates instance_dir
    command "tomcat7-instance-create -p #{new_resource.http_port} -c #{new_resource.control_port} #{instance_dir}"
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
    supports  :manage_home => true
  end
  
  execute "chown -R #{instance_user}:#{instance_group} #{instance_dir}" do
    not_if "stat -c %U #{instance_dir}/webapps | grep #{instance_user}"
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

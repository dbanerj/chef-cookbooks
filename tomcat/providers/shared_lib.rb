action :create do
   lib_dir  = "#{node[:tomcat][:instance_dir]}/#{new_resource.instance}/lib"
   
   directory lib_dir
   
   execute "Copy #{new_resource.name} to lib folder" do
     command "cp #{new_resource.source} #{lib_dir}/#{new_resource.name}"
     creates "#{lib_dir}/#{new_resource.name}"
   end
end
# Directory in which tomcat instances will be created
default[:tomcat][:instance_dir]     = "/srv/tomcat"
# Directory where the LWRP resource expects to find the webapplications
default[:tomcat][:applications_dir] = "/opt/webapps"
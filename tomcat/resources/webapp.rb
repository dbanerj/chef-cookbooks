actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :group, :kind_of => String
attribute :http_port, :kind_of => Integer
attribute :control_port, :kind_of => Integer
attribute :secure, :kind_of => String
attribute :scheme, :kind_of => String
attribute :proxy_port, :kind_of => Integer
attribute :jdk_home, :kind_of => String

attribute :war, :kind_of => String

# General JAVA_OPTS
attribute :java_opts, :kind_of => String

# Default memory settings per environment
attribute :java_opts_test, :kind_of => String, :default => "-XX:MaxPermSize=128m -Xmx512m"
attribute :java_opts_acc, :kind_of => String, :default => "-XX:MaxPermSize=256m -Xmx1024m"
attribute :java_opts_prod, :kind_of => String, :default => "-XX:MaxPermSize=256m -Xmx2048m"

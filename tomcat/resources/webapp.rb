actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :group, :kind_of => String
attribute :http_port, :kind_of => Integer
attribute :control_port, :kind_of => Integer
attribute :secure, :kind_of => String, :default => "false"
attribute :scheme, :kind_of => String, :default => "http"
attribute :proxy_port, :kind_of => Integer, :default => 8080
attribute :jdk_home, :kind_of => String

attribute :war, :kind_of => String
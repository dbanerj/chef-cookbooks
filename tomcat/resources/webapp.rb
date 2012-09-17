actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :group, :kind_of => String
attribute :http_port, :kind_of => Integer
attribute :control_port, :kind_of => Integer

attribute :war, :kind_of => String
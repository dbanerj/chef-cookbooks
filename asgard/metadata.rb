maintainer          "Innovation District B.V."
maintainer_email    "info@innovation-district.com"
license             "Copyright 2012 Innovation District. All rights reserved"
description         "Deploys Netflix Asgard"
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version             "0.0.1"

%w(tomcat).each { |cb| depends cb }
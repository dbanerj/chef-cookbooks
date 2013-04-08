maintainer          "Innovation District B.V."
maintainer_email    "info@innovation-district.com"
license             "Copyright 2012-2013 Innovation District. All rights reserved"
description         "LWRP for deploying Java webapplications in dedicated Tomcat instances"
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version             "0.0.9-dev"

%w(java apt).each { |cb| depends cb }
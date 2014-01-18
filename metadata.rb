# -*- coding: UTF-8 -*-
name             'openstack-omnibus'
maintainer       'Craig Tracey'
maintainer_email 'craigtracey@gmail.com'
license          'Apache 2.0'
description      'A wrapper cookbook for integrating omnibus-openstack with the Chef for OpenStack cookbooks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '8.0.0'

recipe           'openstack-omnibus::default', 'Default recipe'
recipe           'openstack-omnibus::node_attributes', 'Sets node attributes for upstream cookbooks'
recipe           'openstack-omnibus::upstart_services', 'Installs upstart services for omnibus-openstack services'

%w{ ubuntu }.each do |os|
  supports os
end

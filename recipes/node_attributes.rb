# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Recipe:: node_attributes
#
# Copyright 2014, Craig Tracey <craigtracey@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

enabled_services = node['openstack']['omnibus']['enabled_services']

# this is not ideal, but he stackforge cookbooks make this a reality
if enabled_services.include? 'identity'
  %w{keystone mysql_python postgresql_python memcache_python}.each do |type|
    node.set['openstack']['identity']['platform']["#{type}_packages"] = []
  end
end

if enabled_services.include? 'image'
  %w{image image_client swift mysql_python postgresql_python}.each do |type|
    node.set['openstack']['image']['platform']["#{type}_packages"] = []
  end
end

if enabled_services.include? 'compute'
  %w{
    mysql_python
    postgresql_python
    api_ec2
    api_os_compute
    memcache_python
    neutron_python
    compute_api_metadata
    compute_compute
    compute_network
    compute_scheduler
    compute_conductor
    compute_vncproxy
    compute_vncproxy_consoleauth
    compute_cert
    common
  }.each do |type|
    node.set['openstack']['compute']['platform']["#{type}_packages"] = []
  end
end

if enabled_services.include? 'dashboard'
  %w{mysql_python
     postgresql_python
     db2_python
     memcache_python
     horizon
  }.each do |type|
    node.set['openstack']['dashboard']['platform']["#{type}_packages"] = []
  end
  node.set['openstack']['dashboard']['dash_path'] = '/opt/openstack/horizon'
  node.set['openstack']['dashboard']['wsgi_path'] = node['openstack']['dashboard']['dash_path'] + '/wsgi/django.wsgi'
end

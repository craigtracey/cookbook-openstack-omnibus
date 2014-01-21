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
enabled_clients = node['openstack']['omnibus']['enabled_clients']

# we do this in 2 parts because we want the clients to be front of path
env = []
enabled_clients.each do |client|
  project_name = node['openstack']['omnibus']['clients'][client]['project_name']
  env.push "/opt/openstack/#{project_name}/bin"
end

enabled_services.each do |service|
  project_name = node['openstack']['omnibus']['services'][service]['project_name']
  env.push "/opt/openstack/#{project_name}/bin"
end

environment = env.join(':')
ENV['PATH'] = "#{environment}:#{ENV['PATH']}"

template '/etc/profile.d/omnibus-openstack.sh' do
  source 'omnibus-openstack-profile.erb'
  mode 0755
  owner 'root'
  group 'root'
  variables(
    environment: environment
  )
end

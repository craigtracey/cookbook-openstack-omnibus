# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Recipe:: clients
#
# Copyright 2014, Craig Tracey <craigtracey@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class ::Chef::Recipe
  include ::OpenstackOmnibus
end

enabled_projects = get_enabled_projects
omnibus_path = node['openstack']['omnibus']['omnibus_path']

# service commands like: keystone-manage, nova-manage, etc.
enabled_projects.each do |project|
  next if project == 'dashboard'

  project_name = node['openstack']['omnibus']['projects'][project]['project_name']
  commands = node['openstack']['omnibus']['projects'][project]['commands'] || []

  commands.each do |command|
    client_name = File.basename command
    execute "update alternatives for #{client_name}" do
      command "update-alternatives --install /usr/local/bin/#{client_name} #{client_name} #{omnibus_path}/#{project_name}/#{command} 100"
    end
  end
end

# project clients: glance, nova, keystone, etc.
node['openstack']['omnibus']['enabled_clients'].each do |client|
  project_name = node['openstack']['omnibus']['clients'][client]['project_name']
  client_name = node['openstack']['omnibus']['clients'][client]['client_name']

  execute "update alternatives for #{client_name}" do
    command "update-alternatives --install /usr/local/bin/#{client_name} #{client_name} #{omnibus_path}/#{project_name}/bin/#{client_name} 100"
  end
end

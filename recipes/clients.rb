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

node['openstack']['omnibus']['enabled_services'].each do |service|

  next if service == 'dashboard'

  project_name = node['openstack']['omnibus']['services'][service]['project_name']
  commands = node['openstack']['omnibus']['services'][service]['commands'] || []

  commands.each do |command|
    client_name = File.basename command
    execute "update alternatives for #{client_name}" do
      command "update-alternatives --install /usr/local/bin/#{client_name} #{client_name} /opt/openstack/#{project_name}/#{command} 100"
    end
  end
end

node['openstack']['omnibus']['enabled_clients'].each do |client|
  project_name = node['openstack']['omnibus']['clients'][client]['project_name']
  client_name = node['openstack']['omnibus']['clients'][client]['client_name']

  execute "update alternatives for #{client_name}" do
    command "update-alternatives --install /usr/local/bin/#{client_name} #{client_name} /opt/openstack/#{project_name}/bin/#{client_name} 100"
  end
end

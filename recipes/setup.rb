# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Recipe:: setup
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
enabled_projects.each do |project|

  next if project == 'dashboard'

  omnibus_path = node['openstack']['omnibus']['omnibus_path']
  project_params = node['openstack']['omnibus']['projects'][project]

  log_dir = project_params['log_dir']
  username = project_params['user']
  project_name = project_params['project_name']

  user username do
    system true
    shell '/bin/false'
  end

  directory log_dir do
    owner username
    group username
    mode 0755
    action :create
  end

  directory "/etc/#{project_name}" do
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end

  # while i hate the execute resource, there is really
  # no better way to do this
  execute "Copy default configuration from #{project}" do
    omnibus_project_etc_path = "#{omnibus_path}/#{project_name}/etc"
    # some projects have configs in project/etc/project, whilst others have configs in
    # project/etc/
    if FileTest.directory?("#{omnibus_project_etc_path}/#{project_name}")
      command "cp -R #{omnibus_project_etc_path}/#{project_name}/* /etc/#{project_name}"
    else
      command "cp -R #{omnibus_project_etc_path}/* /etc/#{project_name}"
    end
    action :run
  end

end

# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Recipe:: upstart_services
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

class ::Chef::Recipe
  include ::OpenstackOmnibus
end

omnibus_path = node['openstack']['omnibus']['omnibus_path']

upstart_job_dir = node['openstack']['omnibus']['upstart_job_dir']
upstart_job_suffix = node['openstack']['omnibus']['upstart_job_suffix']

expanded_services = get_expanded_services
expanded_services.each do |project, service|

  next if project == 'dashboard'

  project_params = node['openstack']['omnibus']['projects'][project]
  project_user = project_params.user
  project_venv = File.join(omnibus_path, project_params.venv)
  project_config_dir = project_params.config_dir

  service_params = project_params.services[service]
  service_config_files = []
  if service_params.key? 'config_files'
    service_config_files = service_params.config_files
  end

  template "#{upstart_job_dir}/#{service}#{upstart_job_suffix}" do
    source 'upstart/openstack-service.erb'
    mode 0644
    variables(
      upstart_job_dir: upstart_job_dir,
      upstart_job_suffix: upstart_job_suffix,
      service_name: service,
      service_command: service_params.command,
      service_user: project_user,
      project_venv: project_venv,
      project_config_dir: project_config_dir,
      config_files: service_config_files
    )
    # dont restart for now...or ever perhaps
    # notifies :restart, "service[#{service}]", :delayed
  end

  link "/etc/init.d/#{service}" do
    to '/lib/init/upstart-job'
  end

end

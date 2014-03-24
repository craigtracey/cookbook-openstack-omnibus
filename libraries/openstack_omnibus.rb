# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Library:: openstack_omnibus
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

require 'set'

module ::OpenstackOmnibus

  def get_enabled_projects
    projects = Set.new
    node['openstack']['omnibus']['enabled_services'].each do |service|
      parts = service.split('.')
      raise "Incorrect enabled_service format '#{service}'" if parts.length > 2
      projects.add(parts[0])
    end
    projects.to_a
  end

  def get_expanded_services
    expanded_services = []
    node['openstack']['omnibus']['enabled_services'].each do |service|
      parts = service.split('.')
      raise "Incorrect enabled_service format '#{service}'" if parts.length > 2
      if parts.length == 1
        project = parts[0]
        if !node['openstack']['omnibus']['projects'].keys.include? project
          return []
        end
        proj_services = node['openstack']['omnibus']['projects'][project]['services'].keys
        proj_services.each do |service_name|
          expanded_services.push([project, service_name])
        end
      else
        expanded_services.push([parts[0], parts[1]])
      end
    end
    expanded_services
  end

end

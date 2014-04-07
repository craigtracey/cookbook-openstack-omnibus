# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Attributes:: dashboard
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

if enabled_projects.include? 'dashboard'

  omnibus_path = node['openstack']['omnibus']['omnibus_path']

  user 'horizon' do
    action :create
  end

  directory '/etc/openstack-dashboard/local' do
    owner     'root'
    group     'horizon'
    mode      '0644'
    recursive true
    action    :create
  end

  link '/etc/openstack-dashboard/local/local_settings.py' do
    to "#{omnibus_path}/horizon/openstack_dashboard/local/local_settings.py"
  end

end

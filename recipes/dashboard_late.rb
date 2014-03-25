# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Attributes:: dashboard_late
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

  # I really, really hate this kind of stuff, but envvars seems to not be
  # supported by the apache2 cookbooks, nor does apache2 seem to have any
  # kind of conf.d for envvars, so this...heh. I will come up with a
  # better way to support this.
  template '/etc/apache2/envvars' do
    source 'apache_envvars.erb'
    owner 'root'
    group 'root'
    mode '0644'

    notifies :restart, 'service[apache2]'
    variables(
      omnibus_path: node['openstack']['omnibus']['omnibus_path']
    )
  end

end

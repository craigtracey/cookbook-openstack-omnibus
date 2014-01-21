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

enabled_services = node['openstack']['omnibus']['enabled_services']

enabled_services.each do |service|
  log_dir = node['openstack']['omnibus']['services'][service]['log_dir']
  username = node['openstack']['omnibus']['services'][service]['user']

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
end

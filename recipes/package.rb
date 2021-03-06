# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Recipe:: package
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

package_install_method = node['openstack']['omnibus']['package_install_method']

case package_install_method
when 'repo'
  package node['openstack']['omnibus']['package_name'] do
    action :install
  end
when 'url'
  package = node['openstack']['omnibus']['package_url']
  unless package.nil?
    bash 'install openstack' do
      user 'root'
      cwd '/tmp'
      code <<-EOH
      URL='#{package}'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
      EOH
    end
  end
end

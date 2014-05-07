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

case node['openstack']['omnibus']['package_install_method']
when 'repo'
  package node['openstack']['omnibus']['package_name']
when 'url'
  package_url = node['openstack']['omnibus']['package_url']

  unless package_url.nil?
    package_name = package_url.split('/')[-1]
    download_path = "/tmp/#{package_name}"

    if ::File.exists?(download_path)
      Chef::Log.info("#{download_path} already exists, skipping download")
    else
      remote_file download_path do
        source package_url
      end
    end

    dpkg_package package_name do
      source download_path
    end
  end
end

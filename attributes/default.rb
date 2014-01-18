# -*- coding: UTF-8 -*-
# Cookbook Name:: openstack-omnibus
# Attributes:: default
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

default['openstack']['omnibus']['enabled_services'] = %w{
  identity
  image
}

default['openstack']['omnibus']['services'] = {
  'identity' => {
    'project_name' => 'keystone',
    'venv' => '/opt/openstack/keystone',
    'config_dir' => '/etc/keystone',
    'services' => {
      'keystone' => {
        'command' => 'bin/keystone-all',
        'user' => 'keystone',
      }
    }
  },
  'image' => {
    'project_name' => 'glance',
    'venv' => '/opt/openstack/glance',
    'config_dir' => '/etc/glance',
    'services' => {
      'glance-api' => {
        'command' => 'bin/glance-api',
        'user' => 'glance',
      },
      'glance-registry' => {
        'command' => 'bin/glance-registry',
        'user' => 'glance',
      },
    }
  },
}

default['openstack']['omnibus']['enabled_clients'] = %w{
  identity
  image
}
default['openstack']['omnibus']['clients'] = {
  'identity' => {
    'project_name' => 'keystoneclient',
  },
  'image' => {
    'project_name' => 'glanceclient',
  },
}

# upstart
default['openstack']['omnibus']['upstart_job_dir'] = '/etc/init/'
default['openstack']['omnibus']['upstart_job_suffix'] = '.conf'

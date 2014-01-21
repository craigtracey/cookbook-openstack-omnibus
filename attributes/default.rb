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

default['openstack']['omnibus']['package_url'] = nil

default['openstack']['omnibus']['enabled_services'] = %w{
  identity
  image
  compute
}

default['openstack']['omnibus']['services'] = {
  'identity' => {
    'project_name' => 'keystone',
    'venv' => '/opt/openstack/keystone',
    'config_dir' => '/etc/keystone',
    'log_dir' => '/var/log/keystone',
    'user' => 'keystone',
    'services' => {
      'keystone' => {
        'command' => 'bin/keystone-all',
      }
    }
  },
  'image' => {
    'project_name' => 'glance',
    'venv' => '/opt/openstack/glance',
    'config_dir' => '/etc/glance',
    'log_dir' => '/var/log/glance',
    'user' => 'glance',
    'services' => {
      'glance-api' => {
        'command' => 'bin/glance-api',
      },
      'glance-registry' => {
        'command' => 'bin/glance-registry',
      },
    }
  },
  'compute' => {
    'project_name' => 'nova',
    'venv' => '/opt/openstack/nova',
    'config_dir' => '/etc/nova',
    'log_dir' => '/var/log/nova',
    'user' => 'nova',
    'services' => {
      'nova-api-os-compute' => {
        'command' => 'bin/nova-api-os-compute'
      },
      'nova-conductor' => {
        'command' => 'bin/nova-conductor'
      },
      'nova-compute' => {
        'command' => 'bin/nova-compute'
      },
      'nova-scheduler' => {
        'command' => 'bin/nova-scheduler'
      },
      'nova-api-metadata' => {
        'command' => 'bin/nova-api-metadata'
      },
      'nova-api-ec2' => {
        'command' => 'bin/nova-api-ec2'
      },
      'nova-cert' => {
        'command' => 'bin/nova-cet'
      },
      'nova-vncproxy' => {
        'command' => 'bin/nova-vncproxy'
      },
      'nova-consoleauth' => {
        'command' => 'bin/nova-consoleauth'
      },
      'nova-network' => {
        'command' => 'bin/nova-network'
      },
    }
  },
}

default['openstack']['omnibus']['enabled_clients'] = %w{
  identity
  image
  compute
}
default['openstack']['omnibus']['clients'] = {
  'identity' => {
    'project_name' => 'keystoneclient',
  },
  'image' => {
    'project_name' => 'glanceclient',
  },
  'compute' => {
    'project_name' => 'novaclient',
  },

}

# upstart
default['openstack']['omnibus']['upstart_job_dir'] = '/etc/init/'
default['openstack']['omnibus']['upstart_job_suffix'] = '.conf'

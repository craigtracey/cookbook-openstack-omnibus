cookbook-openstack-omnibus
==========================
A wrapper cookbook for integrating openstack-omnibus with the upstream [stackforge](https://github.com/stackforge) Chef for OpenStack repositories with artifacts built with [omnibus-openstack](https://github.com/craigtracey/omnibus-openstack).

About
=====
The primary objective for this cookbook is to wrap the Stackforge cookbooks without requiring any modifications to those Chef resources. This is not always possible as system packages often perform various tasks out of band from a Chef run (ie. create users, create paths, etc.)  And, as not all of these tasks are captured in the Stackforge cookbooks, you may see some of this kind of resource cleanup in this cookbook. As this is a work in progress, fixing these issues here is the path of least resistence (read: a hack). These will eventually be upstreamed to the Stackforge cookbooks.

Usage
=====
In the simplest cases, so long as you set the 'enabled_services' attribute and make your omnibus-openstack artifacts available to the node, including the default recipe in your runlist should be enough to get you started.

default['openstack']['omnibus']['enabled_services'] - this attribute is an array of services to be enabled. We want to easily allow one to very easily define which services will run on a node. The format for the stirng in this array is <project>[.<service>]. An example would look something like this:

This will install all OpenStack glance services on the node.
```
%w('compute')
```

This will install all keystone services as well as the nova-compute and nova-api-os-compute services.
```
%w('compute.nova-compute', 'compute.nova-api-os-compute', 'identity')
```

Todos (in no particular order)
==============================
* Support for OS's other than Ubuntu...should mostly JustWork
* Support all of the core services
* Test Kitchen!
* Extend documentation
* We need tests!
* Travis integration and eventually Gerrit integration
* Did I say we need tests?

License and Author
==================

Copyright 2013-2014, Craig Tracey <craigtracey@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[![Circle CI](https://circleci.com/gh/rackspace-cookbooks/ohai_public_info.svg?style=svg)](https://circleci.com/gh/rackspace-cookbooks/ohai_public_info)

# ohai_public_info

ohai_public_info is a Chef library cookbook to install the public_info Ohai plugin
and allow tagging of a node with its public IP.

## Supported Platforms

* Ubuntu 12.04 
* Ubuntu 14.04
* CentOS 6.5

## Usage

Place a dependency on the ohai_public_info cookbook in your cookbook's metadata.rb

```
depends 'ohai_public_info'
```

Then, in a recipe:

```
ohai_public_info 'default'
```

## Resources

### ohai_public_info

Install ohai `plugin_info` plugin (which populates attributes like `node['public_info']['remote_ip']`)

#### public_ip_tag

Tags the node with its `node['public_info']['remote_ip']` attribute in the
following form: `RemoteIP:{remote_ip}`, but will not add the tag if the node's
'normal' IP matches its public IP.

### Examples

#### Install ohai plugin info and tag a node with its plublic ip

```
ohai_public_info 'default'
public_ip_tag 'default'
```

```
$- knife node show just-a-node

node Name:   just-a-node
Environment: production
FQDN:        just-a-node.example.com
IP:          10.0.0.1
...
Tags:        RemoteIP:9.8.7.6
```

## Authors

Author:: Rackspace (devops-chef@rackspace.com)

## License
```
# Copyright 2015, Rackspace Hosting
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
```

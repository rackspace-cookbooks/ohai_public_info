# Encoding: utf-8
name             'ohai_public_info'
maintainer       'Rackspace'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license          'Apache 2.0'
description      'Installs/Configures ohai_public_info.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url      'https://github.com/rackspace-cookbooks/ohai_public_info'
issues_url       'https://github.com/rackspace-cookbooks/ohai_public_info/issues'
version          '0.1.1'

depends 'ohai'
depends 'poise', '~> 2.0.0'

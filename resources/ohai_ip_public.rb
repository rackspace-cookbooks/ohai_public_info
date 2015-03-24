# require 'chef/resource/lwrp_base'
class Chef
  class Resource
    class OhaiIpPublic < Chef::Resource::LWRPBase
      self.resource_name = 'ohai_ip_public'

      actions :create
      default_action :create

      attribute :plugin_path, kind_of: String, default: '/etc/chef/ohai_plugins'
    end
  end
end

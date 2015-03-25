# require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class OhaiIpPublic < Chef::Resource::LWRPBase
      self.resource_name = 'ohai_ip_public'

      def whyrun_supported?
       true
      end

      actions :install
      default_action :install

    end
  end
end

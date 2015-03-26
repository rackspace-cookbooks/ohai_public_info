class Chef
  class Resource
    class PublicIpTag < Chef::Resource::LWRPBase
      self.resource_name = 'public_ip_tag'

      def whyrun_supported?
        true
      end

      actions :tag
      default_action :tag
    end
  end
end

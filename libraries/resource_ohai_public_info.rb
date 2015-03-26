class Chef
  class Resource
    class OhaiPublicInfo < Chef::Resource::LWRPBase
      self.resource_name = 'ohai_public_info'

      def whyrun_supported?
        true
      end

      actions :install
      default_action :install
    end
  end
end

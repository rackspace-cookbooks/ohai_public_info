class Chef
  class Provider
    class OhaiIpPublic < Chef::Provider::LWRPBase
      include Chef::DSL::IncludeRecipe

      use_inline_resources if defined?(use_inline_resources)


    end
  end
end

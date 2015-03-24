class Chef
  class Provider
    class OhaiIpPublic < Chef::Provider::LWRPBase
      include Chef::DSL::IncludeRecipe

      use_inline_resources if defined?(use_inline_resources)

      action :create do
        include_recipe 'chef-sugar'

        # Fail in a slightly more descriptive manner than the directory block below
        #  if the plugin directory is unset.
        if node['ohai'] && node['ohai']['plugin_path'].nil?
          fail 'ERROR: Ohai plugin path not set'
        end

        # Ensure the plugin directory exists
        directory node['ohai']['plugin_path'] do
          owner 'root'
          group 'root'
          mode  '0755'
          recursive true
          action :nothing
        end.run_action(:create)

        cookbook_file "#{node['ohai']['plugin_path']}/public_info.rb" do
          owner 'root'
          group 'root'
          mode  '0644'
          action :nothing
        end.run_action(:create)

        ohai 'reload_pubinfo' do
          plugin 'public_info'
          action :nothing
        end.run_action(:reload)

        # Stop the run if the IP is invalid, assume failure here is preferable to running with invalid data
        # This check is also important for testing: if the plugin fails to load and operate this exception will
        #  halt convergance breaking Kitchen runs.
        publicinfo_remoteip = node.deep_fetch('public_info', 'remote_ip')

        if publicinfo_remoteip =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/
          # Assign the external_ip tag to the node if node['public_info']['remote_ip'] looks like an IP.
          tag("RemoteIP:#{publicinfo_remoteip}")
        else
          fail "ERROR: Unable to determine server remote IP. (Got \"#{publicinfo_remoteip}\") Halting to avoid use of bad data."
        end
      end
    end
  end
end

require 'chef/provider/lwrp_base'

class Chef
  class Provider::OhaiIpPublic < Chef::Provider::LWRPBase

    use_inline_resources if defined?(use_inline_resources)

    action :install do
      run_context.include_recipe 'chef-sugar'

      # Ensure the plugin directory exists
      directory "#{node['ohai']['plugin_path']}" do
        owner 'root'
        group 'root'
        mode  '0755'
        recursive true
        action :nothing
      end.run_action(:create)

      cookbook_file 'public_info.rb' do
        path  "#{node['ohai']['plugin_path']}/public_info.rb"
        owner 'root'
        group 'root'
        mode  '0644'
        cookbook 'ohai_ip_libraries'
        action :nothing
      end.run_action(:create)

      ohai 'reload_pubinfo' do
        plugin "#{node['ohai']['plugin_path']}/public_info.rb"
        action :nothing
      end.run_action(:reload)

      publicinfo_remoteip = node.deep_fetch('public_info', 'remote_ip')

      # Stop the run if the IP is invalid.
      if publicinfo_remoteip =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/
        # Assign the external_ip tag to the node.
        tags = node['tags']
        node.normal[:tags] = (tags << "RemoteIP:#{publicinfo_remoteip}").uniq!

      else
        fail "ERROR: Unable to determine server remote IP. (Got \"#{publicinfo_remoteip}\") Halting to avoid use of bad data."
      end
    end
  end
end

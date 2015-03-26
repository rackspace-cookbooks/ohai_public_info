class Chef
  class Provider
    class OhaiPublicInfo < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      action :install do
        run_context.include_recipe 'ohai'

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
          cookbook 'ohai_public_info'
          action :nothing
        end.run_action(:create)

        ohai 'reload_pubinfo' do
          plugin "#{node['ohai']['plugin_path']}/public_info.rb"
          action :nothing
        end.run_action(:reload)
      end
    end
  end
end

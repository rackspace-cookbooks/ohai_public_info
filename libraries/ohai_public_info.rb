require 'poise'

class Chef
  class Resource::OhaiPublicInfo < Resource
    include Poise

    actions(:install)
    default_action(:install)
  end

  class Provider::OhaiPublicInfo < Provider
    include Poise

    def action_install
      converge_by("ohai_public_info #{new_resource.name}") do
        notifying_block do
          include_recipe 'ohai'

          cookbook_file 'public_info.rb' do
            path "#{node['ohai']['plugin_path']}/public_info.rb"
            cookbook 'ohai_public_info'
            owner 'root'
            group 'root'
            mode  '0644'
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
end

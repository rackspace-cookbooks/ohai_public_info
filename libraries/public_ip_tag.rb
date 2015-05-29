class Chef
  class Resource::PublicIpTag < Resource
    include Poise

    actions(:tag)
    default_action(:tag)
  end

  class Provider::PublicIpTag < Provider
    include Poise
    include OhaiPublicInfoCookbook::Helpers

    def action_tag
      converge_by("public_ip_tag #{new_resource.name}") do
        require 'ipaddress'
        begin
          # Validate and format IP addresses
          remote_ip = IPAddress(node['public_info']['remote_ip']).address
        rescue
          data = runtime_attribute('public_info', node['ohai']['plugin_path'])
          remote_ip = data['remote_ip']
        end
        tags = node.tags
        existing_ip_tags = tags.grep(/^RemoteIP:/)

        # Don't set the tag if it's already listed as the IP
        if remote_ip == IPAddress(node['ipaddress']).address
          Chef::Log.info("\"#{remote_ip}\" is already defined as the node IP,")
          Chef::Log.info("so we don't need to add a duplicate tag.")
        # Don't set multiple tags.
        elsif existing_ip_tags.count > 0
          Chef::Log.info("Removing the following existing tag(s): #{existing_ip_tags}.")
          existing_ip_tags.each { |t| tags.delete(t) }
          Chef::Log.info("Adding the following tag: #{remote_ip}")
          tags << "RemoteIP:#{remote_ip}"
        # Add the new tag.
        else
          Chef::Log.info("Creating new RemoteIP:#{remote_ip} tag.")
          tags << "RemoteIP:#{remote_ip}"
        end
      end
    end
  end
end

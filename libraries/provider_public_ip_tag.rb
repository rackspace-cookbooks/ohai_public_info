require 'ipaddress'

class Chef
  class Provider
    class PublicIpTag < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      action :tag do
        # Validate and format IP addresses
        remote_ip = IPAddress(node['public_info']['remote_ip']).address
        tags = node.tags
        old_tags = tags.grep(/^RemoteIP:/)

        # Don't set the tag if it's already listed as the IP
        if remote_ip == IPAddress(node['ipaddress']).address
          Chef::Log.info("\"#{remote_ip.address}\" is already defined as the node IP,")
          Chef::Log.info("so we don't need to add a duplicate tag.")
        # Don't set multiple tags.
        elsif old_tags.count > 0
          Chef::Log.info("Replacing the following tags: #{old_tags}.")
          old_tags.each do |old_tag|
            tags.delete(old_tag)
          end
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

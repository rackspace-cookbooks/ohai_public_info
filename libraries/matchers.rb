if defined?(ChefSpec)
  ChefSpec.define_matcher :ohai_public_info

  # Examples:
  #   expect(chef_run).to install_public_info('test')
  #   expect(chef_run).to tag_public_ip_tag('test')

  def tag_public_ip(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:public_ip_tag, :tag, resource)
  end

  def install_public_info(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ohai_public_info, :install, resource)
  end
end

module OhaiPublicInfoCookbook
  module Helpers
    require 'ohai'

    def runtime_attribute(attr_name, plugin_path)
      Ohai::Config[:plugin_path] = plugin_path
      o = Ohai::System.new
      o.all_plugins
      o.data
      return o.data[attr_name]
    end
  end
end

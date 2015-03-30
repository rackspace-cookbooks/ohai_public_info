# Encoding: utf-8
require 'spec_helper'

describe file("#{node['ohai']['plugin_path']}/public_info.rb") do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 0644 }
end

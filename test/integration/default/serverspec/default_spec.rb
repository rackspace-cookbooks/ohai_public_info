# Encoding: utf-8

require 'spec_helper'

describe file('/etc/chef/ohai_plugins/public_info.rb') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

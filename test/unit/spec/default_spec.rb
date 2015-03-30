# Encoding: utf-8

require_relative 'spec_helper'

describe 'public_ip' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'installs public_info plugin' do
    expect(chef_run).to install_public_info('test')
  end

  it 'tags the public ip' do
    expect(chef_run).to tag_public_ip('test')
  end
end

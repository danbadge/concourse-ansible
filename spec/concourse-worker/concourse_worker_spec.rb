require 'spec_helper'

describe service('concourse-worker') do
  it { should be_enabled }
  it { should be_running }
end

describe 'linux kernel version' do
  it 'should have a kernel version greater than 3.19' do
  	full_version = linux_kernel_parameter('kernel.osrelease').value
  	kernel = full_version[0,4].to_f
  	expect(kernel).to be >= 3.19
  end
end
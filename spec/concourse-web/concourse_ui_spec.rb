require 'spec_helper'

describe service('concourse-ui') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

describe port(2222) do
  it { should be_listening }
end
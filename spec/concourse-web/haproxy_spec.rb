require 'spec_helper'
require 'net/http'
require 'uri'

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe port(443) do
  it { should be_listening }
end

describe port(80) do
  it { should be_listening }
end

describe "Concourse Web health check" do
	it "should return 200 OK" do
	    uri = URI.parse("https://#{ENV['TARGET_HOST']}/api/v1/info")
	    puts "GET #{uri}"
	    http = Net::HTTP.new(uri.host, uri.port)
	    http.use_ssl = true
	    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	    request = Net::HTTP::Get.new(uri.request_uri)
	    response = http.request(request)
	    expect(response.code).to match /200/
	end
end

describe "Redirect http to https" do
	it "should return 302 with https location header" do
	    uri = URI.parse("http://#{ENV['TARGET_HOST']}/api/v1/info")
	    puts "GET #{uri}"
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Get.new(uri.request_uri)
	    response = http.request(request)
	    expect(response.code).to match /302/
	    expect(response["Location"]).to match /https:\/\//
	end
end
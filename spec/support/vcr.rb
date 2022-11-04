# frozen_string_literal: true

require 'vcr'
require 'yaml'
require 'webmock/rspec'

VCR.configure do |vcr|
  vcr.configure_rspec_metadata!
  vcr.cassette_library_dir = 'spec/fixtures/cassettes'
  vcr.hook_into :webmock
  vcr.allow_http_connections_when_no_cassette = true
  vcr.filter_sensitive_data('<API_KEY>') { ENV.fetch('HERE_API_KEY') }
  vcr.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV.fetch('GOOGLE_API_KEY') }
end

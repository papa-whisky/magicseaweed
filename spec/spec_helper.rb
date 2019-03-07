# frozen_string_literal: true

require 'bundler/setup'
require 'magicseaweed'
require 'pry'
require 'webmock/rspec'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

WebMock.disable_net_connect!

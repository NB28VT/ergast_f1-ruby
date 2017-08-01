require "bundler/setup"
require "ergast_f1"
require "expected_vars/season"
require "expected_vars/race"
require "vcr"
require "pry"

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock

# Prevent VCR from saving response as a binary
 c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
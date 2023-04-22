ENV["RAILS_ENV"] ||= "test"

# Stop MiniTest from monkey-patching Object with expectations
ENV["MT_NO_EXPECTATIONS"] = "true"

require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"

# Use MiniTest::Reporters to allow for post-test reporting/formatting
require "minitest/reporters"

Dir[Rails.root.join("test", "support", "**", "*.rb")].each { |f| require f }

primary_reporter =
  if ENV.fetch("TEST_FORMAT", "spec") == "plain"
    Minitest::Reporters::DefaultReporter
  else
    Minitest::Reporters::SpecReporter
  end

Minitest::Reporters.use!(
  [
    primary_reporter.new,
    TerminalReporter.new,
    Nanoleaf::Reporter.new
  ],
  ENV,
  Minitest.backtrace_filter
)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers, unless we're running in spec mode
    # This is only because parallelization messes up the spec output
    parallelize(workers: :number_of_processors) unless ENV.fetch("TEST_FORMAT", "spec") == "spec"
  end
end

# Enable FactoryBot helpers in all tests
MiniTest::Test.include FactoryBot::Syntax::Methods

ActionDispatch::IntegrationTest.include RoutesTestHelper

Capybara.app_host = "http://marathonstream.localhost"
Capybara.save_path = "tmp/capybara"

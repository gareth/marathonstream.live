ENV["RAILS_ENV"] ||= "test"

# Stop MiniTest from monkey-patching Object with expectations
ENV["MT_NO_EXPECTATIONS"] = "true"

require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"

require "minitest/reporters"

Dir[Rails.root.join("test", "support", "**", "*.rb")].each { |f| require f }

Minitest::Reporters.use!(
  [
    Minitest::Reporters::DefaultReporter.new,
    TerminalReporter.new
  ],
  ENV,
  Minitest.backtrace_filter
)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end

# Enable FactoryBot helpers in all tests
MiniTest::Test.include FactoryBot::Syntax::Methods

ActionDispatch::IntegrationTest.include RoutesTestHelper

Capybara.app_host = "http://marathonstream.test"

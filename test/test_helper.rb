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
  if ENV.fetch("TEST_FORMAT", "spec") == "spec"
    Minitest::Reporters::SpecReporter
  else
    Minitest::Reporters::DefaultReporter
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

module SubdomainChanger
  def subdomain!(subdomain)
    domain = ActionDispatch::Http::URL.extract_domain(integration_session.host, ActionDispatch::Http::URL.tld_length)
    integration_session.host = URI("//#{subdomain}.#{domain}").host
  rescue URI::InvalidURIError
    raise ArgumentError, format("Invalid subdomain %<subdomain>p for domain %<domain>p", subdomain:, domain:)
  end
end

# Use `ActiveSupport::TestCase` as a base class for *all* `describe` blocks.
# Disabled in favour of opting-in to specific test behaviours like `:model` but
# left in the code as a reminder that test superclass is important.
# Minitest::Spec.register_spec_type(ActiveSupport::TestCase) { true }

# Enable FactoryBot helpers in all tests
Minitest::Test.include FactoryBot::Syntax::Methods

ActionDispatch::IntegrationTest.include RoutesTestHelper
ActionDispatch::IntegrationTest.include SubdomainChanger

Capybara.app_host = "http://marathonstream.localhost"
Capybara.save_path = "tmp/capybara"

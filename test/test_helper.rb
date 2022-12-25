ENV["RAILS_ENV"] ||= "test"

# Stop MiniTest from monkey-patching Object with expectations
ENV["MT_NO_EXPECTATIONS"] = "true"

require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end

# Enable FactoryBot helpers in all tests
MiniTest::Test.include FactoryBot::Syntax::Methods

# Allows spec files to be run using `rails test filename:lineno`
#
# I'm not entirely sure why Minitest specs can't be run this way by default, but
# according to foreman[1], this approach fixes it
#
# [1]: https://github.com/theforeman/foreman/pull/5856
module MinitestSpecAliasing
  def self.included(base)
    class << base
      alias_method :test, :it
    end
  end
end

# These are the test classes that need extending with this functionality
ActionDispatch::IntegrationTest.include(MinitestSpecAliasing)
ActiveSupport::TestCase.include(MinitestSpecAliasing)
ActionController::TestCase.include(MinitestSpecAliasing)

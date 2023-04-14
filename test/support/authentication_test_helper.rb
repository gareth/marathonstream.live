require_relative "test_controller"

# Our authentication relies on information stored in the session. In integration
# tests, Rails doesn't allow you to pre-fill session data. Instead you're
# expected to simulate the real request that would generate the corresponding
# session data. This is a problem - the login method will be OAuth and that's
# going to be tricky to replicate. So this controller is only available in the
# test environment and sets the corresponding values.
#
# We will need to be careful in the future to ensure that the values this sets
# are the values that the genuine login sets when it's implemented.
class TestSessionsController < TestController
  def create
    session["test.role"] = params.fetch(:role)
  end
end

module AuthenticationTestHelper
  extend ActiveSupport::Concern

  class_methods do
    # Define a block of tests with specific personas in mind.
    #
    # This will:
    # 1. Create a `describe` block for each role listed
    # 2. Sign that user in at the beginning of the test
    def as(*roles, &)
      stack = Minitest::Spec.describe_stack
      stack.extend MinitestSpecStackPopper unless stack.is_a?(MinitestSpecStackPopper)

      roles.each do |role|
        (@roles_described ||= Set.new) << role

        describe "as a #{role}" do
          # Before each test, simulate logging the user in
          before do
            draw_test_routes { resource :test_session }
            post test_session_url(role:)
          end

          # Process the test definitions inside this authenticated block
          class_eval(&)
        end
      end
    end

    alias_method :as_a, :as

    def as_anyone(&)
      as(*Role.values, &)
    end

    # Sets a block to be run for roles that aren't explicitly called via `as`
    def as_other(&block)
      @roles_remaining_context = block
    end

    alias_method :otherwise, :as_other

    # In tests relating to a specific channel, we have to make requests to a
    # specific subdomain. To enable requests and URL helpers (for assertions) to
    # work, we can set `default_url_options` on the integration test object
    # itself, and the values will be used throughout the test.
    def use_channel(**attributes)
      let(:channel) { create(:twitch_channel, **attributes) }

      before do
        self.default_url_options = { subdomain: channel }
      end
    end
  end

  # Mutates the Minitest::Spec stack with hooks to check which roles have been
  # specified.
  #
  # As you write nested `describe` blocks, Minitest keeps track of the stack of
  # contexts that you've created.
  #
  # As tests run that use authentication, they call the `as` helper, which adds
  # a list of tested roles to the @roles_described collection for that block.
  #
  # When each `describe` block finishes, Minitest "pops" the stack to jump out
  # to the previous level. This module intercepts that call and uses it to check
  # which roles were tested. If there are any roles that haven't been tested, we
  # inject a "fake" failing test. Sneaky!
  #
  # All in all, this is some nasty, nasty, overly complicated metaprogramming.
  module MinitestSpecStackPopper
    def pop
      spec = last
      if spec.instance_variable_defined?("@roles_described")
        expected_roles = Set.new(Role.values.map(&:to_sym))
        missing_roles = expected_roles - spec.instance_variable_get("@roles_described")

        if missing_roles.any?
          if (remaining_context = spec.instance_variable_get("@roles_remaining_context"))
            last.as(*missing_roles, &remaining_context)
          else
            last.it "doesn't test all roles" do
              flunk format("Forgot to test roles: %s", missing_roles.join(", "))
            end
          end
        end
      end

      super
    end
  end
end

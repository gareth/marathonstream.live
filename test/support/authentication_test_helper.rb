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
    session[:role] = params.fetch(:role).to_sym
  end
end

module AuthenticationTestHelper
  extend ActiveSupport::Concern

  class_methods do
    # Define a block of tests with specific personas in mind.
    #
    # This will:
    # 1. Create a `describe` block for each role listed
    # 2. Create a relevant User in the `current_user` variable
    # 3. Sign that user in at the beginning of the test
    def as(*roles, **attributes, &)
      roles.each do |role|
        describe "as a #{role}" do
          # Set up the user (lazily)
          let(:current_user) { create(:user_session, role, **attributes) }

          # Before each test, simulate logging the user in
          before do
            draw_test_routes { resource :test_session }
            post test_session_url(role: current_user.role)
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
end

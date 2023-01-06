# Allow (additional) routes to be defined for the duration of a test.
#
# This is useful for testing controller concerns because it allows you to:
# 1. Define a custom controller
# 2. Mix your concern into it
# 3. Define routes that your test can use to hit the controller # <- THIS BIT
module RoutesTestHelper
  extend ActiveSupport::Concern

  def draw_test_routes(&)
    # Don't clear routes when calling `Rails.application.routes.draw`
    Rails.application.routes.disable_clear_and_finalize = true

    Rails.application.routes.draw do
      scope "test" do
        instance_exec(&)
      end
    end

    # Only add the reload-on-teardown the first time we define routes
    self.class.teardown { reload_routes! } unless self.class.draw_test_routes_teardown_set
    self.class.draw_test_routes_teardown_set = true
  end

  def reload_routes!
    Rails.application.reload_routes!
  end

  class_methods do
    attr_accessor :draw_test_routes_teardown_set
  end
end

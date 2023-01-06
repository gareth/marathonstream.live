module AuthenticationTestHelper
  extend ActiveSupport::Concern

  class_methods do
    # Define a block of tests with specific personas in mind.
    #
    # This will:
    # 1. Create a `describe` block for each role listed
    # 2. Create a relevant User in the `current_user` variable
    # 3. [TODO] Sign that user in at the beginning of your test
    def as(*roles, **attributes, &)
      roles.each do |role|
        describe "as a #{role}" do
          let(:current_user) { create(:user, role, **attributes) }

          class_eval(&)
        end
      end
    end

    alias_method :as_a, :as

    def use_channel(**attributes)
      let(:channel) { create(:twitch_channel, **attributes) }

      before do
        self.default_url_options = { subdomain: channel }
      end
    end
  end
end

require "test_helper"

describe SessionsController do
  include AuthenticationTestHelper

  describe "#show" do
    as(:anonymous) do
      it "returns profile information as JSON" do
        get session_url(format: :json)

        assert_response :not_found
      end
    end

    otherwise do
      it "returns profile information as JSON" do
        get session_url(format: :json)

        assert_equal "application/json", mime_type(response)
      end
    end
  end

  describe "#create" do
    def login_via_twitch_oauth
      post "/auth/twitch"
      follow_redirect!
    end

    describe "with Twitch authentication" do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.add_mock(:twitch, oauth)
      end

      describe "for a new user" do
        let(:oauth) { create(:twitch_oauth, display_name: "TriCeraTops", uid: 424_242) }

        it "creates a user" do
          assert_difference(-> { Twitch::User.count }) do
            login_via_twitch_oauth
          end
        end

        it "sets the user's details" do
          login_via_twitch_oauth

          user = Twitch::User.find_by(uid: 424_242)
          assert_equal "triceratops", user.login
          assert_equal "TriCeraTops", user.display_name
          assert_equal oauth["credentials"]["token"], user.token
          assert_equal oauth["credentials"]["refresh_token"], user.refresh_token
        end
      end

      describe "for an existing user" do
        let(:user) { create(:twitch_user, uid: 434_343, display_name: "ExistingUsername") }
        let(:oauth) { create(:twitch_oauth, uid: user.uid, display_name: "NewUsername") }

        it "doesn't create a user" do
          assert_no_difference(-> { Twitch::User.count }) do
            login_via_twitch_oauth
          end
        end

        it "updates user details" do
          login_via_twitch_oauth

          user.reload

          assert_equal "NewUsername", user.display_name
        end
      end
    end
  end

  def mime_type(response)
    header = response.headers["Content-Type"]
    content_type = header.match ActionDispatch::Response::CONTENT_TYPE_PARSER
    content_type[:mime_type]
  end
end

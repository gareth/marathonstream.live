require "test_helper"
require "capybara/minitest"

describe ChannelsController do
  include AuthenticationTestHelper

  include Capybara::Minitest::Assertions

  describe "for a nonexistant channel" do
    let(:channel) { build(:twitch_channel) }

    before do
      self.default_url_options = { subdomain: channel }
    end

    describe "#show" do
      as(:admin, :broadcaster) do
        it "offers to create the channel" do
          get channel_url

          assert_content "Create"
          assert_response :success
        end
      end

      otherwise do
        it "tells you there's no channel" do
          get channel_url

          refute_content "Create"
          assert_response :not_found
        end
      end
    end

    describe "#create" do
      as(:broadcaster, :admin) do
        it "creates the channel" do
          assert_difference(-> { Twitch::Channel.count }) do
            post channel_url
          end

          assert_redirected_to root_url
        end
      end

      otherwise do
        it "is restricted" do
          assert_no_difference(-> { Twitch::Channel.count }) do
            post channel_url
          end

          assert_response :forbidden
        end
      end
    end
  end

  describe "for an existing channel" do
    use_channel

    describe "#show" do
      as(:admin, :broadcaster, :moderator) do
        it "shows broadcaster navigation" do
          get channel_url

          assert_selector "nav.broadcaster-admin"
        end
      end

      otherwise do
        it "doesn't show broadcaster navigation" do
          get channel_url

          refute_selector "nav.broadcaster-admin"
        end
      end

      describe "with no active stream" do
        as_anyone do
          it "shows no active stream" do
            get channel_url

            assert_content "no active stream"
          end
        end
      end

      describe "with an active stream" do
        before do
          create(:stream, :active, twitch_channel: channel, title: "Active Stream")
        end

        as_anyone do
          it "renders the page" do
            get channel_url

            assert_response :success
          end

          it "displays the active stream" do
            get channel_url

            assert_no_content "no active stream"
            assert_content "Active Stream"
          end
        end
      end
    end

    describe "#create" do
      as(:admin, :broadcaster) do
        it "just redirects to the channel page" do
          assert_no_difference(-> { Twitch::Channel.count }) do
            post channel_url
          end

          assert_redirected_to root_url
          assert_response :found
        end
      end

      otherwise do
        it "is restricted" do
          assert_no_difference(-> { Twitch::Channel.count }) do
            post channel_url
          end

          assert_response :forbidden
        end
      end
    end

    describe "#update" do
      as(:broadcaster, :admin) do
        it "saves channel option settings" do
          assert_changes(-> { channel.reload.sync_moderators }) do
            patch channel_url, params: {
              channel: { sync_moderators: true }
            }
          end
        end
      end

      otherwise do
        it "is restricted" do
          patch channel_url

          assert_response :forbidden
        end
      end
    end

    describe "#destroy" do
      as(:broadcaster, :admin) do
        it "clears the channel" do
          assert_difference(-> { Twitch::Channel.count }, -1) do
            delete channel_url
          end

          assert_redirected_to root_url
        end
      end

      otherwise do
        it "is restricted" do
          assert_no_difference(-> { Twitch::Channel.count }) do
            delete channel_url
          end

          assert_response :forbidden
        end
      end
    end
  end
end

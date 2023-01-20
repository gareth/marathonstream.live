require "test_helper"
require "capybara/minitest"

describe ChannelsController do
  include AuthenticationTestHelper

  include Capybara::Minitest::Assertions

  use_channel

  describe "#show" do
    as(:broadcaster, :admin) do
      it "shows broadcaster navigation" do
        get channel_url

        assert_selector "nav.broadcaster-admin"
      end
    end

    as(:viewer) do
      it "doesn't show broadcaster navigation" do
        get channel_url

        refute_selector "nav.broadcaster-admin"
      end
    end

    describe "with no active stream" do
      as(:viewer) do
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

      as(:viewer) do
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
end

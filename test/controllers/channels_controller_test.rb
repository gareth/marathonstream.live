require "test_helper"
require "capybara/minitest"

describe ChannelsController do
  include AuthenticationTestHelper

  include Capybara::Minitest::Assertions

  use_channel

  describe "with an active stream" do
    before do
      create(:stream, :active, twitch_channel: channel)
    end

    as(:viewer) do
      it "renders the page" do
        get channel_url

        assert_response :success
      end

      it "displays the current channel" do
        get channel_url

        within "main" do
          assert_content channel.to_s
        end
      end

      it "displays the active stream"
    end
  end
end

require "application_system_test_case"

describe "Channel settings", :system do
  include AuthenticationSystemTestHelper

  use_channel

  as(:broadcaster, :admin, :moderator) do
    it "can update channel settings" do
      visit edit_channel_url(channel_name: channel)
      check "Sync moderators"

      click_on "Update Channel"
    end
  end

  otherwise do
    it "is restricted" do
      visit edit_channel_url(channel_name: channel)
      skip "No error page to detect yet"
    end
  end
end

require "test_helper"

describe TwitchUser do
  it "is linked to a channel by UID" do
    channel = create(:twitch_channel, twitch_id: 20_001)
    user = create(:twitch_user, uid: 20_001)

    assert_equal channel, user.reload.channel
  end
end

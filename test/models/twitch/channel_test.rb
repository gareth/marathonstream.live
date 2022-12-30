require "test_helper"

describe Twitch::Channel do
  describe "#to_s" do
    it "displays as the display name" do
      assert_equal "FoOoBaR", build(:twitch_channel, display_name: "FoOoBaR").to_s
    end
  end

  describe "#to_param" do
    it "displays as the parameterised version of the username" do
      assert_equal "fooobar", build(:twitch_channel, display_name: "FoOoBaR").to_param
    end
  end
end

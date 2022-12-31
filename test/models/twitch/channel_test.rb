require "test_helper"

describe Twitch::Channel do
  describe "#to_s" do
    it "displays as the display name" do
      assert_equal "FooBaR", build(:twitch_channel, display_name: "FooBaR").to_s
    end
  end

  describe "#to_param" do
    it "displays as the parameterised version of the username" do
      assert_equal "foobar", build(:twitch_channel, display_name: "FooBaR").to_param
    end
  end
end

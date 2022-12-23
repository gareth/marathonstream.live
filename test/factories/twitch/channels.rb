FactoryBot.define do
  factory :twitch_channel, class: "Twitch::Channel" do
    twitch_id { "MyString" }
    twitch_username { "MyString" }
    twitch_display_name { "MyString" }
  end
end

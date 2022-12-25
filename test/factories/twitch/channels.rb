FactoryBot.define do
  factory :twitch_channel, class: "Twitch::Channel" do
    sequence(:twitch_id)
    twitch_username { twitch_display_name.downcase }
    twitch_display_name { "HeliX#{twitch_id}" }
  end
end

FactoryBot.define do
  factory :twitch_channel, class: "TwitchChannel" do
    twitch_id
    username { display_name.downcase }
    display_name { "HeliX#{twitch_id}" }
  end
end

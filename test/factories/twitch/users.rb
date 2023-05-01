FactoryBot.define do
  factory :twitch_user, class: "Twitch::User" do
    sequence(:uid) { generate(:twitch_id) }
    display_name { "TwitchUser#{uid}" }
    login { display_name.downcase }
    token_scopes { [] }
    token { "012345678901234567890123456789" }
    refresh_token { "01234567890123456789012345678901234567890123456789" }
    token_expires_at { "2023-04-14 08:06:41" }
  end
end

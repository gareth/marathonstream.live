FactoryBot.define do
  factory :stream do
    twitch_channel
    starts_at { "2022-12-23 22:00:00" }
    initial_duration { 10 * 60 * 60 }
  end
end

FactoryBot.define do
  factory :stream do
    twitch_channel { nil }
    starts_at { "2022-12-23 22:50:40" }
    initial_duration { 1 }
  end
end

FactoryBot.define do
  factory :user_session do
    skip_create
    initialize_with { UserSession.new(**attributes) }

    transient do
      twitch_channel { nil }
    end

    role { :viewer }
    identity { nil }

    trait :with_identity do
      identity { create(:twitch_user) }
    end

    trait :admin do
      role { :admin }
      with_identity
    end

    trait :broadcaster do
      role { :broadcaster }
      twitch_channel { create(:twitch_channel) }
      with_identity
    end

    trait :moderator do
      role { :moderator }
      with_identity
    end

    trait :viewer do
      role { :viewer }
    end

    trait :anonymous do
      role { :viewer }
    end
  end
end

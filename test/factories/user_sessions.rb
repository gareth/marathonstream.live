FactoryBot.define do
  factory :user_session do
    skip_create
    initialize_with { UserSession.new(**attributes) }

    role { :viewer }

    Role.each_value do |r|
      trait r do
        role { r }
      end
    end
  end
end

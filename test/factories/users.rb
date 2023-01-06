FactoryBot.define do
  factory :user do
    skip_create
    initialize_with { User.new(**attributes) }

    role { :viewer }

    %i[viewer moderator broadcaster admin].each do |r|
      trait r do
        role { r }
      end
    end
  end
end

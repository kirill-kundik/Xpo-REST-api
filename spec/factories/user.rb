FactoryBot.define do
  factory :user, class: User do
    login { Faker::Internet.username }
    name { Faker::Lorem.word }
    password { Faker::Internet.password(min_length: 6) }
    email { Faker::Internet.email }
    user_role { true }
    organizer_role { false }
    superadmin_role { false }

    factory :organizer do
      organizer_role { true }

      factory :organizer_with_expos do
        transient do
          expos_count { 5 }
        end

        after(:create) do |user, evaluator|
          create_list(:expo, evaluator.expos_count, user: user)
        end
      end

      factory :superadmin do
        superadmin_role { true }
      end
    end
  end
end
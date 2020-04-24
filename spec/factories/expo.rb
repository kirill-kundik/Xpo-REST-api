FactoryBot.define do
  factory :expo, class: Expo do
    user { create(:organizer) }
    name { Faker::Lorem.words.join(' ') }
    description { Faker::Lorem.paragraph }
    image_url { Faker::Internet.url }
    start_time { Faker::Time.forward }
    end_time { Faker::Time.forward }
    location_name { Faker::Nation.capital_city }
    views_count { Faker::Number.number(digits: 3) }

    factory :expo_with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |expo, evaluator|
        comments do
          create_list(
            :comment,
            evaluator.comments_count,
            expo: expo
          )
        end
      end
    end

    factory :expo_wih_models do
      transient do
        models_count { 5 }
      end

      after(:create) do |expo, evaluator|
        create_list(
          :expo_model,
          evaluator.models_count,
          expo: expo
        )
      end
    end
  end
end

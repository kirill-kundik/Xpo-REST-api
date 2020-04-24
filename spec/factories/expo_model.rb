FactoryBot.define do
  factory :expo_model, class: ExpoModel do
    expo { create(:expo) }
    ar_model_url { Faker::Lorem.words }
    marker_url { Faker::Lorem.words }
  end
end
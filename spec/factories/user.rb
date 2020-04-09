FactoryBot.define do
  factory :user do
    login { Faker::Internet.username }
    name { Faker::Lorem.word }
    password { Faker::Internet.password(min_length: 6) }
  end
end
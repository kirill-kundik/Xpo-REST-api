FactoryBot.define do
  factory :student do
    name { ::FFaker::Name.name }
    age { 20 }
    faculty
  end
end

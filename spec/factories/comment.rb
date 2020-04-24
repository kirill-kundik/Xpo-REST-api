FactoryBot.define do
  factory :comment, class: Comment do
    user { create(:user) }
    expo { create(:expo) }
    text { Faker::Lorem.paragraph(sentence_count: 2) }
    likes_count { Faker::Number.number(digits: 2) }
  end
end

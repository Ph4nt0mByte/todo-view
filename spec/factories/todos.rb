FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    status { Todo::VALID_STATUSES.sample }
  end
end

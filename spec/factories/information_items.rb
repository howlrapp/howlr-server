FactoryBot.define do
  factory :information_item do
    body { Faker::Lorem.sentences.join("\n") }
  end
end

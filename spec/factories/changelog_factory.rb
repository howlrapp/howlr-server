FactoryBot.define do
  factory :changelog do
    body { Faker::Lorem.sentences.join("\n") }
  end
end

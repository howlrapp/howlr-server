FactoryBot.define do
  factory :profile_field do
    name { Faker::Name.unique.name }
    label { Faker::Name.unique.name }
    restricted { [true, false].sample }
  end
end

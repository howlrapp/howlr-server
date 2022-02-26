FactoryBot.define do

  factory :match_kind do
    name { Faker::Name.unique.name }
    label { Faker::Name.unique.name }
  end

end

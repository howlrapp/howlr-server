FactoryBot.define do

  factory :relationship_status do
    name { Faker::Name.unique.name }
    label { Faker::Name.unique.name }
  end

end

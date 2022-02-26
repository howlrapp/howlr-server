FactoryBot.define do

  factory :sexual_orientation do
    name { Faker::Name.unique.name }
    label { Faker::Name.unique.name }
  end

end

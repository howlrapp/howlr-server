FactoryBot.define do

  factory :gender do
    name { Faker::Name.unique.name }
    label { Faker::Name.unique.name }
  end

end

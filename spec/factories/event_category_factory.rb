FactoryBot.define do

  factory :event_category do
    label { Faker::Name.unique.name }
  end

end

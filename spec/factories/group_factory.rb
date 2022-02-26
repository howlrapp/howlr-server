FactoryBot.define do
  factory :group do
    name { Faker::Name.unique.name }
    group_category
  end
end

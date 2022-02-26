FactoryBot.define do

  factory :ban do
    user
    ban_reason { Faker::Lorem.sentence }
  end
end

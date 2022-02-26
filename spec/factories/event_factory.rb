FactoryBot.define do

  factory :event do
    user
    event_category
    title { Faker::Name.first_name }
    address { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
    latitude { 0 }
    longitude { 0 }
    date { rand(30).days.from_now }
    maximum_searchable_distance { rand(100000) }
    privacy_status { "open" }
  end

end

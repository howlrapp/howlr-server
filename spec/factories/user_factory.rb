FactoryBot.define do

  factory :user do
    telegram_username { Faker::Name.first_name }
    bio { Faker::Lorem.sentence }
    state { "visible" }
    sequence(:telegram_id) { |n| n }
    name { Faker::Name.first_name }
    latitude { 0 }
    longitude { 0 }
    last_seen_at { 1.minute.ago }

    after(:create) do |user, evaluator|
      user.update({
        profile_field_values: Hash[
          ProfileField.find_each.map do |profile_field|
            [ profile_field.name, Faker::Name.first_name ]
          end
        ]
      })

      user.reload
    end
  end
end

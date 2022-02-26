FactoryBot.define do
  factory :profile_field_group do
    label { Faker::Name.unique.name }

    transient do
      profile_fields_count { 2 }
    end

    after(:create) do |profile_field_group, evaluator|
      create_list(:profile_field, evaluator.profile_fields_count, profile_field_group: profile_field_group)
    end
  end
end

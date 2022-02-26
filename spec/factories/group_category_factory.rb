FactoryBot.define do

  factory :group_category do
    label { Faker::Name.unique.name }

    transient do
      groups_count { 2 }
    end

    after(:create) do |group_category, evaluator|
      create_list(:group, evaluator.groups_count, group_category: group_category)

      group_category.reload
    end
  end

end

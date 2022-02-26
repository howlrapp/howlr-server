FactoryBot.define do

  factory :like do
    association :liker, factory: :user
    association :liked, factory: :user
  end

end

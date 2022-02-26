FactoryBot.define do

  factory :message do
    association :chat
    association :sender, factory: :user
    body { Faker::Lorem.sentence }
  end

end

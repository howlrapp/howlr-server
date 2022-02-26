FactoryBot.define do

  factory :session do
    user
    version { 1 }
    device { 'test' }

    sequence(:expo_token) { |n| n }
  end

end

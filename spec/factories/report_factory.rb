FactoryBot.define do

  factory :report do
    association :subject, factory: :user
    association :reporter, factory: :user

    description { 'Test report' }
    status { 'new' }
  end

end

FactoryBot.define do

  factory :picture do
    user

    picture do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/pictures/test_picture.jpg'), 'image/jpeg')
    end
  end

end

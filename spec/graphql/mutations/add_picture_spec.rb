require 'rails_helper'

RSpec.describe 'Mutations::AddPicture' do
  let(:user) { FactoryBot.create :user }
  let(:base64_picture) {
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII="
  }

  ADD_PICTURE = %{
    mutation addPicture($input: AddPictureInput!) {
      addPicture(input: $input) {
        picture {
          id
          pictureUrl
          thumbnailUrl
          createdAt
        }
      }
    }
  }

  context "valid_params" do
    it "adds a picture" do
      result = HowlrSchema.execute(ADD_PICTURE,
        context: { current_user: user },
        variables: {
          input: {
            pictureUrl: base64_picture
          }
        }
      )
      expect(result["data"]["addPicture"]["picture"]["id"]).to_not eq(nil)
      expect(result["data"]["addPicture"]["picture"]["pictureUrl"]).to match(/jpg$/)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(ADD_PICTURE,
        context: { current_user: user },
        variables: {
          input: {
            pictureUrl: base64_picture
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to send picture if not connected" do
      result = HowlrSchema.execute(ADD_PICTURE,
        variables: {
          input: {
            pictureUrl: base64_picture
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot send picture with bad picture" do
      result = HowlrSchema.execute(ADD_PICTURE,
        context: { current_user: user },
        variables: {
          input: {
            pictureUrl: "bad picture"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Picture can't be blank")
    end
  end
end

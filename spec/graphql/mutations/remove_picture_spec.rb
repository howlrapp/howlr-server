require 'rails_helper'

RSpec.describe 'Mutations::RemovePicture' do
  let(:user) { FactoryBot.create :user }
  let!(:picture) { FactoryBot.create :picture, user: user }

  let(:other_user) { FactoryBot.create :user }
  let(:other_picture) { FactoryBot.create :picture, user: other_user }

  REMOVE_PICTURE = %{
    mutation removePicture($input: RemovePictureInput!) {
      removePicture(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "remove a picture" do
      expect {
        result = HowlrSchema.execute(REMOVE_PICTURE,
          context: { current_user: user },
          variables: {
            input: {
              pictureId: picture.id
            }
          }
        )
        expect(result["data"]["removePicture"]["id"]).to eq(picture.id)
      }.to change(Picture, :count).by(-1)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_PICTURE,
        context: { current_user: user },
        variables: {
          input: {
            pictureId: picture.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to remove picture if not connected" do
      result = HowlrSchema.execute(REMOVE_PICTURE,
        variables: {
          input: {
            pictureId: picture.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot remove other picture" do
      result = HowlrSchema.execute(REMOVE_PICTURE,
        context: { current_user: user },
        variables: {
          input: {
            pictureId: other_picture.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Mutations::RemoveAvatar' do
  let(:user) { FactoryBot.create :user }

  REMOVE_AVATAR = %{
    mutation removeAvatar($input: RemoveAvatarInput!) {
      removeAvatar(input: $input) {
        viewer {
          id
          avatarUrl
        }
      }
    }
  }

  context "valid_params" do
    it "remove avatar" do
      result = HowlrSchema.execute(REMOVE_AVATAR,
        context: { current_user: user },
        variables: { input: {} }
      )
      expect(result["data"]["removeAvatar"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["removeAvatar"]["viewer"]["avatarUrl"]).to eq(nil)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_AVATAR,
        context: { current_user: user },
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to remove avatar if not connected" do
      result = HowlrSchema.execute(REMOVE_AVATAR,
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Mutations::UpdateViewer' do
  let(:user) { FactoryBot.create :user }

  let(:base64_picture) {
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII="
  }

  UPDATE_VIEWER = %{
    mutation updateViewer($input: UpdateViewerInput!) {
      updateViewer(input: $input) {
        viewer {
          id
          name
          avatarUrl
        }
      }
    }
  }

  context "valid_params" do
    it "update viewer" do
      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            name: "blah"
          }
        }
      )
      expect(result["data"]["updateViewer"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["updateViewer"]["viewer"]["name"]).to eq("blah")
    end

    it "update viewer avatar" do
      expect(user.avatar_url).to eq(nil)

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            avatarUrl: base64_picture
          }
        }
      )
      expect(result["data"]["updateViewer"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["updateViewer"]["viewer"]["avatarUrl"]).to match(/jpg$/)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            avatarUrl: base64_picture
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to update user if not connected" do
      result = HowlrSchema.execute(UPDATE_VIEWER,
        variables: {
          input: {
            name: "blah"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "it fails if some sub stuff doesn't exist" do
      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            genderIds: ["blah"]
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            relationshipStatusId: "blah"
          }
        }
      )
      expect(result["data"]["updateViewer"]["viewer"]["relationshipStatusId"]).to eq(nil)

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            matchKindIds: ["blah"]
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            sexualOrientationIds: ["blah"]
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")

      result = HowlrSchema.execute(UPDATE_VIEWER,
        context: { current_user: user.reload },
        variables: {
          input: {
            groupIds: ["blah"]
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end
  end
end

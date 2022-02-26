require 'rails_helper'

RSpec.describe 'Mutations::SetProfileFieldValue' do
  let(:user) { FactoryBot.create :user }

  SET_PROFILE_FIELD_VALUE = %{
    mutation setProfileFieldValue($input: SetProfileFieldValueInput!) {
      setProfileFieldValue(input: $input) {
        profileFieldValue {
          id
          name
          value
          restricted
        }
      }
    }
  }

  context "valid_params" do
    it "adds a profile field value" do
      result = HowlrSchema.execute(SET_PROFILE_FIELD_VALUE,
        context: { current_user: user },
        variables: {
          input: {
            name: "awesome",
            value: "wonbat",
          }
        }
      )
      expect(result["data"]["setProfileFieldValue"]["profileFieldValue"]["id"]).to_not eq(nil)
      expect(result["data"]["setProfileFieldValue"]["profileFieldValue"]["name"]).to eq("awesome")
      expect(result["data"]["setProfileFieldValue"]["profileFieldValue"]["value"]).to eq("wonbat")
      expect(result["data"]["setProfileFieldValue"]["profileFieldValue"]["restricted"]).to eq(false)
      expect(user.reload.profile_field_values["awesome"]).to eq("wonbat")

      # add another and check both still exists
      other_result = HowlrSchema.execute(SET_PROFILE_FIELD_VALUE,
        context: { current_user: user },
        variables: {
          input: {
            name: "daniel",
            value: "craig",
            restricted: true
          }
        }
      )
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["id"]).to_not eq(nil)
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["name"]).to eq("daniel")
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["value"]).to eq("craig")
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["restricted"]).to eq(true)
      expect(user.reload.profile_field_values["daniel"]).to eq("craig")
      expect(user.reload.profile_field_values["awesome"]).to eq("wonbat")
      expect(user.reload.restricted_profile_fields).to include("daniel")

      # Remove restriction
      other_result = HowlrSchema.execute(SET_PROFILE_FIELD_VALUE,
        context: { current_user: user },
        variables: {
          input: {
            name: "daniel",
            value: "other_craig",
            restricted: false
          }
        }
      )

      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["id"]).to_not eq(nil)
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["name"]).to eq("daniel")
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["value"]).to eq("other_craig")
      expect(other_result["data"]["setProfileFieldValue"]["profileFieldValue"]["restricted"]).to eq(false)
      expect(user.reload.profile_field_values["daniel"]).to eq("other_craig")
      expect(user.reload.profile_field_values["awesome"]).to eq("wonbat")
      expect(user.reload.restricted_profile_fields).to_not include(["daniel"])
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(SET_PROFILE_FIELD_VALUE,
        context: { current_user: user },
        variables: {
          input: {
            name: "awesome",
            value: "wonbat"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to set profile field value if not connected" do
      result = HowlrSchema.execute(SET_PROFILE_FIELD_VALUE,
        variables: {
          input: {
            name: "awesome",
            value: "wonbat"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

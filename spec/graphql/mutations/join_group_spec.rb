require 'rails_helper'

RSpec.describe 'Mutations::JoinGroup' do
  let!(:user) { FactoryBot.create :user }

  let!(:group_category) { FactoryBot.create :group_category }
  let!(:group) { FactoryBot.create :group, group_category: group_category }

  JOIN_GROUP = %{
    mutation joinGroup($input: JoinGroupInput!) {
      joinGroup(input: $input) {
        group {
          id
        }
      }
    }
  }

  context "valid_params" do
    it "join a group" do
      expect {
        result = HowlrSchema.execute(JOIN_GROUP,
          context: { current_user: user },
          variables: {
            input: {
              groupId: group.id,
            }
          }
        )
        expect(result["data"]["joinGroup"]["group"]["id"]).to eq(group.id)
      }.to change(GroupUser, :count).by(1)
    end
  end

  context "invalid_params" do
    it "is not authorized to join group if not connected" do
      result = HowlrSchema.execute(JOIN_GROUP,
        variables: {
          input: {
            groupId: group.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot join group without groupId" do
      result = HowlrSchema.execute(JOIN_GROUP,
        context: { current_user: user },
        variables: {
          input: {
            groupId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end

    it "cannot join group if maximum joined group is reached" do
      Rails.configuration.maximum_joined_groups_count.times do
        group = FactoryBot.create(:group, group_category: group_category)
        group.users.push user
      end

      result = HowlrSchema.execute(JOIN_GROUP,
        context: { current_user: user },
        variables: {
          input: {
            groupId: group.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

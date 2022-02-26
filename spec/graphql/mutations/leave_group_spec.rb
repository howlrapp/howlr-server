require 'rails_helper'

RSpec.describe 'Mutations::LeaveGroup' do
  let!(:user) { FactoryBot.create :user }

  let!(:group_category) { FactoryBot.create :group_category }
  let!(:group) { FactoryBot.create :group, group_category: group_category }

  before do
    group.users.push user
  end

  LEAVE_GROUP = %{
    mutation leaveGroup($input: LeaveGroupInput!) {
      leaveGroup(input: $input) {
        group {
          id
        }
      }
    }
  }

  context "valid_params" do
    it "leave a group" do
      expect {
        result = HowlrSchema.execute(LEAVE_GROUP,
          context: { current_user: user },
          variables: {
            input: {
              groupId: group.id,
            }
          }
        )
        expect(result["data"]["leaveGroup"]["group"]["id"]).to eq(group.id)
      }.to change(GroupUser, :count).by(-1)
    end
  end

  context "invalid_params" do
    it "is not authorized to leave group if not connected" do
      result = HowlrSchema.execute(LEAVE_GROUP,
        variables: {
          input: {
            groupId: group.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot leave group without groupId" do
      result = HowlrSchema.execute(LEAVE_GROUP,
        context: { current_user: user },
        variables: {
          input: {
            groupId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end
  end
end

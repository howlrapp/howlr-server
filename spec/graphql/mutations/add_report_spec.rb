require 'rails_helper'

RSpec.describe 'Mutations::AddReport' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_report) { FactoryBot.create :user }

  ADD_REPORT = %{
    mutation addReport($input: AddReportInput!) {
      addReport(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "adds a report" do
      result = HowlrSchema.execute(ADD_REPORT,
        context: { current_user: user },
        variables: {
          input: {
            subjectId: user_i_report.id,
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["data"]["addReport"]["id"]).to_not eq(nil)
    end

    it "can block but without effect" do
      user.update(blocked_users_ids: [user_i_report.id])
      result = HowlrSchema.execute(ADD_REPORT,
        context: { current_user: user },
        variables: {
          input: {
            subjectId: user_i_report.id,
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["data"]["addReport"]["id"]).to_not eq(nil)
    end

    it "can get blocked but without effect" do
      user_i_report.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_REPORT,
        context: { current_user: user },
        variables: {
          input: {
            subjectId: user_i_report.id,
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["data"]["addReport"]["id"]).to_not eq(nil)
    end

    it "can report without valid subjectId" do
      user_i_report.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_REPORT,
        context: { current_user: user },
        variables: {
          input: {
            subjectId: "nobody",
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["data"]["addReport"]["id"]).to_not eq(nil)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(ADD_REPORT,
        context: { current_user: user },
        variables: {
          input: {
            subjectId: user_i_report.id,
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to reprot if not connected" do
      result = HowlrSchema.execute(ADD_REPORT,
        variables: {
          input: {
            subjectId: user_i_report.id,
            subjectType: "User",
            description: "blah"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

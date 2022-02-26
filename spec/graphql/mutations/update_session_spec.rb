require 'rails_helper'

RSpec.describe 'Mutations::UpdateSession' do
  let(:user) { FactoryBot.create :user }
  let(:session) { FactoryBot.create :session, user: user }

  UPDATE_SESSION = %{
    mutation updateSession($input: UpdateSessionInput!) {
      updateSession(input: $input) {
        session {
          id
          expoToken
        }
      }
    }
  }

  context "valid_params" do
    it "update session" do
      result = HowlrSchema.execute(UPDATE_SESSION,
        context: { current_session: session.reload, current_user: user.reload },
        variables: {
          input: {
            expoToken: "blah"
          }
        }
      )
      expect(result["data"]["updateSession"]["session"]["id"]).to eq(session.id)
      expect(result["data"]["updateSession"]["session"]["expoToken"]).to eq("blah")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(UPDATE_SESSION,
        context: { current_session: session.reload, current_user: user.reload },
        variables: {
          input: {
            expoToken: "blah"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to update session if not connected" do
      result = HowlrSchema.execute(UPDATE_SESSION,
        variables: {
          input: {
            expoToken: "blah"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

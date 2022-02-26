require 'rails_helper'

RSpec.describe 'Queries::SessionQuery' do
  let(:user) { FactoryBot.create :user }
  let(:session) { FactoryBot.create :session, user: user }

  GET_SESSION = %{
    {
      session {
        id
        expoToken
        device
        version
        createdAt
        lastSeenAt
      }
    }
  }

  context "valid_params" do
    it "can get session with user" do
      result = HowlrSchema.execute(GET_SESSION,
        context: { current_session: session.reload, current_user: user.reload },
      )
      expect(result["data"]["session"]["id"]).to eq(session.id)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_SESSION,
        context: { current_session: session.reload, current_user: user.reload },
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get session without user" do
      result = HowlrSchema.execute(GET_SESSION)
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end
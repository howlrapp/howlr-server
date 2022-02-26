require 'rails_helper'

RSpec.describe 'Mutations::RemoveSession' do
  let!(:user) { FactoryBot.create :user }
  let!(:other_user) { FactoryBot.create :user }

  REMOVE_SESSION = %{
    mutation removeSession($input: RemoveSessionInput!) {
      removeSession(input: $input) {
        id
      }
    }
  }

  context "valid_params, no id" do
    let!(:session) { FactoryBot.create :session, user: user }

    it "remove session" do
      ActiveJob::Base.queue_adapter = :test

      expect(user.reload.state).to eq("visible")
      expect {
        result = HowlrSchema.execute(REMOVE_SESSION,
          context: { current_session: session, current_user: user },
          variables: { input: {} }
        )
        expect(result["data"]["removeSession"]["id"]).to eq(session.id)
      }.to change(Session, :count).by(-1)
      expect(user.reload.state).to eq("hidden")

      # check user state while we're at it
      another_session = FactoryBot.create :session, user: user
      yet_another_session = FactoryBot.create :session, user: user
      expect(user.reload.state).to eq("visible")
      another_session.destroy!
      expect(user.reload.state).to eq("visible")
      yet_another_session.destroy!
      expect(user.reload.state).to eq("hidden")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_SESSION,
        context: { current_session: session, current_user: user },
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "valid_params, id" do
    let!(:session) { FactoryBot.create :session, user: user }
    let!(:other_session) { FactoryBot.create :session, user: other_user }

    it "remove session by id" do
      ActiveJob::Base.queue_adapter = :test

      expect(user.reload.state).to eq("visible")
      expect {
        result = HowlrSchema.execute(REMOVE_SESSION,
          context: { current_session: session, current_user: user },
          variables: { input: { sessionId: session.id } }
        )
        expect(result["data"]["removeSession"]["id"]).to eq(session.id)
      }.to change(Session, :count).by(-1)
      expect(user.reload.state).to eq("hidden")
    end

    it "can't remove other_user session by id" do
      result = HowlrSchema.execute(REMOVE_SESSION,
        context: { current_session: session, current_user: user },
        variables: { input: { sessionId: other_session.id } }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to remove sesion if not connected" do
      result = HowlrSchema.execute(REMOVE_SESSION,
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

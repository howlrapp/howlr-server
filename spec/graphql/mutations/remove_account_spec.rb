require 'rails_helper'

RSpec.describe 'Mutations::RemoveAccount' do
  let(:user) { FactoryBot.create :user }

  REMOVE_ACCOUNT = %{
    mutation removeAccount($input: RemoveAccountInput!) {
      removeAccount(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "remove account" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        result = HowlrSchema.execute(REMOVE_ACCOUNT,
          context: { current_user: user },
          variables: { input: {} }
        )
        expect(result["data"]["removeAccount"]["id"]).to eq(user.id)
      }.to have_enqueued_job
    end

    it "cat get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_ACCOUNT,
        context: { current_user: user },
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to remove account if not connected" do
      result = HowlrSchema.execute(REMOVE_ACCOUNT,
        variables: { input: {} }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

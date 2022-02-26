require 'rails_helper'

RSpec.describe 'Mutations::RemoveEvent' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }

  let!(:event_category) { FactoryBot.create :event_category }

  let!(:user_i_like_event) {
    FactoryBot.create(:event, {
      user: user_i_like,
      title: "user_i_like_event",
      event_category: event_category
    })
  }

  let!(:my_event) {
    FactoryBot.create(:event, {
      user: user,
      title: "my_event",
      event_category: event_category
    })
  }

  REMOVE_EVENT = %{
    mutation removeEvent($input: RemoveEventInput!) {
      removeEvent(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "remove my event" do
      expect {
        result = HowlrSchema.execute(REMOVE_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventId: my_event.id,
            }
          }
        )
        expect(result["data"]["removeEvent"]["id"]).to eq(my_event.id)
      }.to change(Event, :count).by(-1)
    end
  end

  context "invalid_params" do
    it "is not authorized to remove event if not connected" do
      result = HowlrSchema.execute(REMOVE_EVENT,
        variables: {
          input: {
            eventId: my_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot remove event without eventId" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(REMOVE_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end

    it "cannot remove other event" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(REMOVE_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: user_i_like_event.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

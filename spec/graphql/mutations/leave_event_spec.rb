require 'rails_helper'

RSpec.describe 'Mutations::LeaveEvent' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }

  let!(:event_category) { FactoryBot.create :event_category }

  let!(:user_i_like_event) {
    FactoryBot.create(:event, {
      user: user_i_like,
      title: "user_i_like_event",
      event_category: event_category,
      users: [user]
    })
  }

  let!(:my_event) {
    FactoryBot.create(:event, {
      user: user,
      title: "my_event",
      event_category: event_category
    })
  }

  LEAVE_EVENT = %{
    mutation leaveEvent($input: LeaveEventInput!) {
      leaveEvent(input: $input) {
        event {
          id
        }
      }
    }
  }

  context "valid_params" do
    it "leave a event" do
      expect {
        result = HowlrSchema.execute(LEAVE_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventId: user_i_like_event.id,
            }
          }
        )
        expect(result["data"]["leaveEvent"]["event"]["id"]).to eq(user_i_like_event.id)
      }.to change(EventUser, :count).by(-1)
    end

    it "can block but can still leave" do
      user.update(blocked_users_ids: [user_i_like.id])
      expect {
        result = HowlrSchema.execute(LEAVE_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventId: user_i_like_event.id,
            }
          }
        )
        expect(result["data"]["leaveEvent"]["event"]["id"]).to eq(user_i_like_event.id)
      }.to change(EventUser, :count).by(-1)
    end

    it "can get blocked but can still leave" do
      user_i_like.update(blocked_users_ids: [user.id])
      expect {
        result = HowlrSchema.execute(LEAVE_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventId: user_i_like_event.id,
            }
          }
        )
        expect(result["data"]["leaveEvent"]["event"]["id"]).to eq(user_i_like_event.id)
      }.to change(EventUser, :count).by(-1)
    end
  end

  context "invalid_params" do
    it "is not authorized to leave event if not connected" do
      result = HowlrSchema.execute(LEAVE_EVENT,
        variables: {
          input: {
            eventId: user_i_like_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot leave event without eventId" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(LEAVE_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end

    it "cannot leave my event" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(LEAVE_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: my_event.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

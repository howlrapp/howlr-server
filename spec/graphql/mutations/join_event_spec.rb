require 'rails_helper'

RSpec.describe 'Mutations::JoinEvent' do
  let!(:user) { FactoryBot.create :user }
  let!(:user_i_like) { FactoryBot.create :user }
  let!(:user_that_likes_me) { FactoryBot.create :user }

  let!(:like_them) { FactoryBot.create :like, liker: user, liked: user_i_like }
  let!(:other_like) { FactoryBot.create :like, liker: user_that_likes_me, liked: user }

  let!(:event_category) { FactoryBot.create :event_category }

  let!(:user_i_like_event) {
    FactoryBot.create(:event, {
      user: user_i_like,
      title: "user_i_like_event",
      event_category: event_category,
      privacy_status: "open"
    })
  }


  let!(:user_that_likes_me_event) {
    FactoryBot.create(:event, {
      user: user_that_likes_me,
      title: "user_that_likes_me_event",
      event_category: event_category,
      privacy_status: "liked_only"
    })
  }

  let!(:my_event) {
    FactoryBot.create(:event, {
      user: user,
      title: "my_event",
      event_category: event_category,
      privacy_status: "liked_only"
    })
  }

  JOIN_EVENT = %{
    mutation joinEvent($input: JoinEventInput!) {
      joinEvent(input: $input) {
        event {
          id
        }
      }
    }
  }

  context "valid_params" do
    before :each do
      my_event.users.push user
      user_i_like_event.users.push user_i_like
      user_that_likes_me_event.users.push user_that_likes_me
    end

    it "join a event" do
      ActiveJob::Base.queue_adapter = :test

      expect(user.reload.events_as_participant_ids_cache).to_not include(user_i_like_event.id)
      expect(user_i_like_event.reload.users_count).to eq(1)

      expect {
        expect {
          result = HowlrSchema.execute(JOIN_EVENT,
            context: { current_user: user },
            variables: {
              input: {
                eventId: user_i_like_event.id,
              }
            }
          )
          expect(result["data"]["joinEvent"]["event"]["id"]).to eq(user_i_like_event.id)
        }.to change(EventUser, :count).by(1)
      }.to have_enqueued_job(PushEventUpdatedCableNotificationJob).once.and have_enqueued_job(PushExpoNotificationJob).once

      expect(user.reload.events_as_participant_ids_cache).to include(user_i_like_event.id)
      expect(user_i_like_event.reload.users_count).to eq(2)
    end

    it "join a event with liked_only" do
      ActiveJob::Base.queue_adapter = :test

      expect(user.reload.events_as_participant_ids_cache).to_not include(user_that_likes_me_event.id)
      expect(user_that_likes_me_event.reload.users_count).to eq(1)

      expect {
        expect {
          result = HowlrSchema.execute(JOIN_EVENT,
            context: { current_user: user },
            variables: {
              input: {
                eventId: user_that_likes_me_event.id,
              }
            }
          )
          expect(result["data"]["joinEvent"]["event"]["id"]).to eq(user_that_likes_me_event.id)
        }.to change(EventUser, :count).by(1)
      }.to have_enqueued_job(PushEventUpdatedCableNotificationJob).once.and have_enqueued_job(PushExpoNotificationJob).once

      expect(user.reload.events_as_participant_ids_cache).to include(user_that_likes_me_event.id)
      expect(user_that_likes_me_event.reload.users_count).to eq(2)
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(JOIN_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: user_i_like_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(JOIN_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: user_i_like_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to join event if not connected" do
      result = HowlrSchema.execute(JOIN_EVENT,
        variables: {
          input: {
            eventId: user_i_like_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot join event without eventId" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(JOIN_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end

    it "cannot join event with liked_only while not being liked" do
      user_i_like_event.update(privacy_status: "liked_only")
      result = HowlrSchema.execute(JOIN_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventId: user_i_like_event.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot join my event" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(JOIN_EVENT,
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

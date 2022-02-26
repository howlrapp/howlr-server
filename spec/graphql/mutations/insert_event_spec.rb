require 'rails_helper'

RSpec.describe 'Mutations::InsertEvent' do
  let(:user) { FactoryBot.create :user, allow_event_created_notification: true }

  let!(:user2) { FactoryBot.create :user, allow_event_created_notification: false }
  let!(:user3) { FactoryBot.create :user, allow_event_created_notification: true }
  let!(:user_that_likes_me) { FactoryBot.create(:user, allow_event_created_notification: false) }
  let!(:like) { FactoryBot.create :like, liker: user_that_likes_me, liked: user }

  let!(:event_category) { FactoryBot.create :event_category }
  let!(:system_event_category) { FactoryBot.create :event_category, system: true }

  INSERT_EVENT = %{
    mutation insertEvent($input: InsertEventInput!) {
      insertEvent(input: $input) {
        event {
          id
        }
      }
    }
  }

  context "valid_params" do
    it "adds a event" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        result = HowlrSchema.execute(INSERT_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventCategoryId: event_category.id,
              title: "title",
              address: "address",
              maximumSearchableDistance: Rails.configuration.events_maximum_searchable_distance,
              date: DateTime.new.iso8601,
              privacyStatus: "open",
              latitude: 0,
              longitude: 0
            }
          }
        )
        expect(result["data"]["insertEvent"]["event"]["id"]).to_not eq(nil)
      }.to have_enqueued_job(PushEventUpdatedCableNotificationJob).exactly(3).times.and have_enqueued_job(PushExpoNotificationJob).once
    end

    it "adds a private event" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        result = HowlrSchema.execute(INSERT_EVENT,
          context: { current_user: user_that_likes_me },
          variables: {
            input: {
              eventCategoryId: event_category.id,
              title: "title",
              address: "address",
              maximumSearchableDistance: Rails.configuration.events_maximum_searchable_distance,
              date: DateTime.new.iso8601,
              privacyStatus: "liked_only",
              latitude: 0,
              longitude: 0
            }
          }
        )
        expect(result["data"]["insertEvent"]["event"]["id"]).to_not eq(nil)
      }.to have_enqueued_job(PushEventUpdatedCableNotificationJob).once.and have_enqueued_job(PushExpoNotificationJob).once
    end
  end

  context "invalid_params" do
    it "is not authorized to create event if not connected" do
      result = HowlrSchema.execute(INSERT_EVENT,
        variables: {
          input: {
            eventCategoryId: event_category.id,
            title: "title",
            address: "address",
            maximumSearchableDistance: 10,
            date: DateTime.new.iso8601,
            privacyStatus: "open",
            latitude: 20,
            longitude: 20
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot create event that can be searched too far" do
      result = HowlrSchema.execute(INSERT_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventCategoryId: event_category.id,
            title: "title",
            address: "address",
            maximumSearchableDistance: Rails.configuration.events_maximum_searchable_distance + 1,
            date: DateTime.new.iso8601,
            privacyStatus: "open",
            latitude: 20,
            longitude: 20
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot create event in system category" do
      result = HowlrSchema.execute(INSERT_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventCategoryId: system_event_category.id,
            title: "title",
            address: "address",
            maximumSearchableDistance: Rails.configuration.events_maximum_searchable_distance,
            date: DateTime.new.iso8601,
            privacyStatus: "open",
            latitude: 20,
            longitude: 20
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot create too many events" do
      Rails.configuration.events_max_per_week.times do
        result = HowlrSchema.execute(INSERT_EVENT,
          context: { current_user: user },
          variables: {
            input: {
              eventCategoryId: event_category.id,
              title: "title",
              address: "address",
              maximumSearchableDistance: 10,
              date: DateTime.new.iso8601,
              privacyStatus: "open",
              latitude: 20,
              longitude: 20
            }
          }
        )
        expect(result["data"]["insertEvent"]["event"]["id"]).to_not eq(nil)
      end

      result = HowlrSchema.execute(INSERT_EVENT,
        context: { current_user: user },
        variables: {
          input: {
            eventCategoryId: event_category.id,
            title: "title",
            address: "address",
            maximumSearchableDistance: 10,
            date: DateTime.new.iso8601,
            privacyStatus: "open",
            latitude: 20,
            longitude: 20
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

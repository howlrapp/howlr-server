require 'rails_helper'

RSpec.describe 'Queries::EventsQuery' do
  let!(:user) { FactoryBot.create :user }

  let!(:some_group) { FactoryBot.create :group }
  let!(:some_other_group) { FactoryBot.create :group }

  let!(:some_gender) { FactoryBot.create :gender }
  let!(:some_other_gender) { FactoryBot.create :gender }

  let!(:some_relationship_status) { FactoryBot.create :relationship_status }
  let!(:some_other_relationship_status) { FactoryBot.create :relationship_status }

  let!(:some_sexual_orientation) { FactoryBot.create :sexual_orientation }
  let!(:some_other_sexual_orientation) { FactoryBot.create :sexual_orientation }

  let!(:user_i_like) {
    FactoryBot.create(:user, {
      groups: [ some_group, some_other_group ],
      relationship_status: some_relationship_status,
      genders: [ some_other_gender ],
      sexual_orientations: [ some_other_sexual_orientation ],
      name: "Toto"
    })
  }
  let!(:user_that_likes_me) {
    FactoryBot.create(:user, {
      genders: [ some_gender ],
      groups: [ some_other_group ],
      relationship_status: some_other_relationship_status,
      sexual_orientations: [ some_sexual_orientation, some_other_sexual_orientation ]
    })
  }

  let!(:like1) { FactoryBot.create :like, liker: user, liked: user_i_like }
  let!(:like2) { FactoryBot.create :like, liker: user_that_likes_me, liked: user }

  let!(:event_category) { FactoryBot.create :event_category }

  let!(:user_i_like_event) {
    FactoryBot.create(:event, {
      user: user_i_like,
      title: "user_i_like_event",
      event_category: event_category,
      users: [ user ]
    })
  }
  let!(:user_i_like_private_event) {
    FactoryBot.create(:event, {
      user: user_i_like,
      title: "user_i_like_event",
      privacy_status: "liked_only",
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
  let!(:user_that_likes_me_event) {
    FactoryBot.create(:event, {
      user: user_that_likes_me,
      title: "user_that_likes_me_event",
      event_category: event_category
    })
  }
  let!(:user_that_likes_me_private_event) {
    FactoryBot.create(:event, {
      user: user_that_likes_me,
      title: "user_that_likes_me_event",
      privacy_status: "liked_only",
      event_category: event_category
    })
  }

  GET_EVENTS = %{
    {
      viewer {
        id
        events {
          id
          title
          date
          localities
          createdAt
          updatedAt
          usersCount
          user {
            id
            name
          }
        }
        eventsAsParticipant {
          id
          title
          date
          localities
          createdAt
          updatedAt
          usersCount
          user {
            id
            name
          }
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
  
    it "can get events" do
      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["events"].count).to eq(4)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(2)

      ids = result["data"]["viewer"]["events"].map { |e| e["id"] }
      expect(ids).to match_array([my_event.id, user_i_like_event.id, user_that_likes_me_event.id, user_that_likes_me_private_event.id])
    end

    it "block users" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["events"].count).to eq(3)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(1)
    end

    it "gets blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["events"].count).to eq(3)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(1)
    end

    it "cannot see events too far" do
      user_i_like_event.update({
        maximum_searchable_distance: 1000,
        latitude: 100,
        longitude: 100,
      })
      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["events"].count).to eq(3)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(2)
    end

    it "cannot see past events" do
      user_i_like_event.update({
        date: (Rails.configuration.past_events_visibility_days_count + 1).days.ago
      })
      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["events"].count).to eq(3)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(2)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_EVENTS,
        context: { current_user: user }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get events if not connected" do
      result = HowlrSchema.execute(GET_EVENTS)
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

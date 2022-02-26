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

  GET_EVENT = %{
    query getEvent($id: ID!) {
      viewer {
        id
        event(id: $id) {
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
  
    it "can get event" do
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_event.id }
      )
      expect(result["data"]["viewer"]["event"]["id"]).to eq(user_i_like_event.id)
      expect(result["data"]["viewer"]["event"]["user"]["id"]).to eq(user_i_like.id)
    end

    it "can get private event from someone who likes me" do
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_that_likes_me_private_event.id }
      )
      expect(result["data"]["viewer"]["event"]["id"]).to eq(user_that_likes_me_private_event.id)
      expect(result["data"]["viewer"]["event"]["user"]["id"]).to eq(user_that_likes_me.id)
    end

    it "cannot get private event from someone who doesnt like me" do
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_private_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "block users" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "gets blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot see events too far" do
      user_that_likes_me_event.update({
        maximum_searchable_distance: 1000,
        latitude: 100,
        longitude: 100,
      })
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_that_likes_me_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot see events too far unless I'm already in" do
      user_i_like_event.update({
        maximum_searchable_distance: 1000,
        latitude: 100,
        longitude: 100
      })
      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_event.id }
      )
      expect(result["data"]["viewer"]["event"]["id"]).to eq(user_i_like_event.id)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_EVENT,
        context: { current_user: user },
        variables: { id: user_i_like_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get event if not connected" do
      result = HowlrSchema.execute(GET_EVENT,
        variables: { id: user_i_like_event.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

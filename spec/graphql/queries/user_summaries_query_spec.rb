require 'rails_helper'

RSpec.describe 'Queries::UsersSummary' do
  let!(:user) { FactoryBot.create :user, share_online_status: false, birthdate: 35.years.ago, hide_birthdate: true }

  let!(:some_group) { FactoryBot.create :group }
  let!(:some_other_group) { FactoryBot.create :group }

  let!(:event_category) { FactoryBot.create :event_category }

  let!(:some_event) { FactoryBot.create :event, event_category: event_category, user: user, maximum_searchable_distance: 1000 * 40000 }
  let!(:some_other_event) { FactoryBot.create :event, event_category: event_category, user: user, maximum_searchable_distance: 1000 * 40000 }
  let!(:event_too_far) { FactoryBot.create :event, event_category: event_category, user: user_i_like, latitude: 20, longitude: 100, maximum_searchable_distance: 1000 * 100 }

  let!(:some_gender) { FactoryBot.create :gender }
  let!(:some_other_gender) { FactoryBot.create :gender }

  let!(:some_relationship_status) { FactoryBot.create :relationship_status }
  let!(:some_other_relationship_status) { FactoryBot.create :relationship_status }

  let!(:some_sexual_orientation) { FactoryBot.create :sexual_orientation }
  let!(:some_other_sexual_orientation) { FactoryBot.create :sexual_orientation }

  let!(:some_match_kind) { FactoryBot.create :match_kind }
  let!(:some_other_match_kind) { FactoryBot.create :match_kind }

  let!(:user_i_like) {
    FactoryBot.create(:user, {
      groups: [ some_group, some_other_group ],
      events_as_participant: [ some_event ],
      relationship_status: some_relationship_status,
      genders: [ some_other_gender ],
      sexual_orientations: [ some_other_sexual_orientation ],
      name: "Toto",
      last_seen_at: (Rails.configuration.online_duration.minutes + 1).ago,
      birthdate: 20.years.ago,
      hide_birthdate: false
    })
  }
  let!(:user_that_likes_me) {
    FactoryBot.create(:user, {
      genders: [ some_gender ],
      groups: [ some_other_group ],
      events_as_participant: [ some_event, some_other_event ],
      relationship_status: some_other_relationship_status,
      sexual_orientations: [ some_sexual_orientation, some_other_sexual_orientation ],
      last_seen_at: (Rails.configuration.online_duration.minutes + 1).ago,
      birthdate: 50.years.ago,
      hide_birthdate: false
    })
  }

  let!(:user_low_karma) {
    FactoryBot.create(:user, {
      bio: nil,
      telegram_username: nil
    })
  }

  GET_USER_SUMMARIES = %{
    query getUserSummaries(
      $groupIds: [String!],
      $eventIds: [String!],
      $genderIds: [String!],
      $sexualOrientationIds: [String!],
      $relationshipStatusIds: [String!],
      $matchKindIds: [String!],
      $online: Boolean,
      $recent: Boolean,
      $likedByMe: Boolean,
      $likingMe: Boolean,
      $ageIds: [String!]
      $q: String
    ) {
      viewer {
        id
        userSummaries(
          groupIds: $groupIds,
          eventIds: $eventIds,
          sexualOrientationIds: $sexualOrientationIds,
          matchKindIds: $matchKindIds,
          genderIds: $genderIds,
          relationshipStatusIds: $relationshipStatusIds,
          online: $online,
          recent: $recent,
          likedByMe: $likedByMe,
          likingMe: $likingMe,
          ageIds: $ageIds
          q: $q
        ) {
          id
          name
          avatarUrl
          online
          distance
        }
      }
    }
  }

  context "valid_params" do

    before :each do
      some_event.users.push user.reload
      some_other_event.users.push user.reload
      event_too_far.users.push user_i_like.reload
    end

    it "can get users" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(3)
    end

    it "can get users in specific groups" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          groupIds: [some_group.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)
    end

    it "can get users in all specific groups" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          groupIds: [some_group.id, some_other_group.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)
    end

    it "can get users in specific eventIds" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          eventIds: [some_other_event.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)

      participants = result["data"]["viewer"]["userSummaries"].map { |user| user['id'] }
      expect(participants).to include(user_that_likes_me.id)
      expect(participants).to include(user.id)
    end

    it "can't get users for event too far away" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          eventIds: [event_too_far.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(0)
    end

    it "can get users for event too far if participant" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user_i_like },
        variables: {
          eventIds: [event_too_far.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]["id"]).to eq(user_i_like.id)
    end

    it "can get users in all specific events" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          eventIds: [some_event.id, some_other_event.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(3)
    end

    it "can get users with specific genders" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          genderIds: [some_gender.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_that_likes_me.id)
    end

    it "can get users by age" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          ageIds: ["18_25"]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          ageIds: ["18_35"]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          ageIds: ["18_100"]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          ageIds: ["18_25", "50_65"]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get users in all specified genders" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          genderIds: [some_gender.id, some_other_gender.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get users with specific relationshipStatus" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          relationshipStatusIds: [some_relationship_status.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          relationshipStatusIds: [some_relationship_status.id, some_other_relationship_status.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get users with specific sexual orientation" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          sexualOrientationIds: [some_sexual_orientation.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_that_likes_me.id)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          sexualOrientationIds: [some_sexual_orientation.id, some_other_sexual_orientation.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get users with specific match_kind" do
      user_i_like.update!(match_kind_ids: [some_match_kind.uuid])
      user_that_likes_me.update!(match_kind_ids: [some_other_match_kind.uuid])

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          matchKindIds: [some_match_kind.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          matchKindIds: [some_match_kind.id, some_other_match_kind.id]
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get users with specific query" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          q: "Toto"
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)
    end

    it "can get online users" do
      user_i_like.update({
        last_seen_at: 0.minutes.ago
      })
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          online: true
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1) # we got two because our own user doesn't share their status
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)
    end

    it "can get recent users" do
      user_i_like.update({
        created_at: (Rails.configuration.recent_users_days_count + 1).days.ago
      })
      user.update({
        created_at: (Rails.configuration.recent_users_days_count + 1).days.ago
      })
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          recent: true
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1) # we got two because our own user doesn't share their status
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_that_likes_me.id)
    end

    it "can get user i like" do
      Like.create(liker: user, liked: user_i_like)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          likedByMe: true
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_i_like.id)
    end

    it "can get user liking me" do
      Like.create(liker: user_that_likes_me, liked: user)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
        variables: {
          likingMe: true
        }
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(1)
      expect(result["data"]["viewer"]["userSummaries"][0]['id']).to eq(user_that_likes_me.id)
    end

    it "block users" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "gets blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "cannot see user too far" do
      user_i_like.update({
        maximum_searchable_distance: 1000,
        latitude: 100,
        longitude: 100,
      })
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "cannot see inactive user" do
      user_i_like.update({
        last_seen_at: (Rails.configuration.idle_days_count.days + 1).ago
      })
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user },
      )
      expect(result["data"]["viewer"]["userSummaries"].count).to eq(2)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        context: { current_user: user }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get users if not connected" do
      result = HowlrSchema.execute(GET_USER_SUMMARIES,
        variables: { id: user_i_like.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end
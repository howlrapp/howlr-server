require 'rails_helper'

RSpec.describe 'Queries::ViewerQuery' do
  GET_VIEWER = %{
    {
      viewer {
        id
        name
        bio
        like
        dislike
        latitude
        longitude
        distanceUnit
        avatarUrl
        online
        shareOnlineStatus
        genderIds
        matchKindIds
        sexualOrientationIds
        relationshipStatusId
        groupIds
        birthdate
        hideBirthdate
        hideNotCommonGroups
        hideLikes
        hideCity
        maximumSearchableDistance
        allowChatNotification
        allowMessageNotification
        allowLikeNotification
        localities
        canChangeLocation
        canCreateEvent
        online
        sessions {
          id
        }
        profileFieldValues {
          id
          name
          value
          restricted
        }
        blockedUsers {
          id
          name
        }
        pictures {
          id
          pictureUrl
          thumbnailUrl
          createdAt
        }
        receivedLikes {
          id
          createdAt
          user {
            id
            name
            distance
            avatarUrl
            online
          }
        }
        sentLikes {
          id
          createdAt
          user {
            id
            name
            distance
            avatarUrl
            online
          }
        }
        events {
          id
          user {
            id
            name
          }
          users {
            id
            name
          }
          title
        }
        eventsAsParticipant {
          id
          title
          date
          localities
          createdAt
          updatedAt
          user {
            id
            name
          }
          users {
            id
            name
          }
        }
        chats {
          id
          unread
          recipientId
          senderId
          matchKindId
          acceptedAt
          updatedAt
          previewMessage {
            id
            body
            pictureUrl
            senderId
          }
          contact {
            id
            name
            avatarUrl
            system
            online
          }
          messages {
            id
            body
            senderId
            createdAt
            thumbnailUrl
            pictureUrl
          }
        }
      }
    }
  }

  context "valid_params" do
    let(:user) { FactoryBot.create :user }
    let(:user_i_like) { FactoryBot.create :user }
    let(:user_that_likes_me) { FactoryBot.create :user }
    let(:user_low_karma) { FactoryBot.create :user, telegram_username: nil, bio: "" }

    let(:match_kind) { FactoryBot.create :match_kind }
  
    let!(:chat1) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind }
    let!(:like1) { FactoryBot.create :like, liker: user, liked: user_i_like }
  
    let!(:chat2) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind }
    let!(:like2) { FactoryBot.create :like, liker: user_that_likes_me, liked: user }

    let!(:chat3) { FactoryBot.create :chat, sender: user_low_karma, recipient: user, match_kind: match_kind }
    let!(:like3) { FactoryBot.create :like, liker: user_low_karma, liked: user }

    let!(:event_category) { FactoryBot.create :event_category }
  
    let!(:user_i_like_event) {
      FactoryBot.create(:event, {
        user: user_i_like,
        title: "user_i_like_event",
        event_category: event_category,
        users: [user, user_that_likes_me]
      })
    }
  
    let!(:user_that_likes_me_event) {
      FactoryBot.create(:event, {
        user: user_that_likes_me,
        title: "user_that_likes_me_event",
        event_category: event_category
      })
    }
  
    let!(:my_event) {
      FactoryBot.create(:event, {
        user: user,
        title: "my_event",
        event_category: event_category,
        users: [user_i_like, user_that_likes_me]
      })
    }

    before :each do
      my_event.users.push user
      user_i_like_event.users.push user_i_like
      user_that_likes_me_event.users.push user_that_likes_me
    end

    it "can get viewer" do
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["name"]).to eq(user.name)
      expect(result["data"]["viewer"]["chats"].count).to eq(2)

      expect(result["data"]["viewer"]["receivedLikes"].count).to eq(1)
      expect(result["data"]["viewer"]["sentLikes"].count).to eq(1)

      expect(result["data"]["viewer"]["events"].count).to eq(3)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(2)
    end

    it "check location change" do
      user.update(location_changed_at: nil)
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["canChangeLocation"]).to eq(true)

      user.update(location_changed_at: (Rails.configuration.location_change_interval_minutes + 2).minutes.ago)
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["canChangeLocation"]).to eq(true)

      user.update(location_changed_at: (Rails.configuration.location_change_interval_minutes - 2).minutes.ago)
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["canChangeLocation"]).to eq(false)
    end

    it "block users" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["chats"].count).to eq(1)
      expect(result["data"]["viewer"]["receivedLikes"].count).to eq(1)
      expect(result["data"]["viewer"]["sentLikes"].count).to eq(0)

      expect(result["data"]["viewer"]["events"].count).to eq(2)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(1)
      expect(result["data"]["viewer"]["eventsAsParticipant"][0]["users"].count).to eq(2)

      user.update(blocked_users_ids: [user_i_like.id, user_that_likes_me.id])
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["chats"].count).to eq(0)
      expect(result["data"]["viewer"]["receivedLikes"].count).to eq(0)
      expect(result["data"]["viewer"]["sentLikes"].count).to eq(0)

      expect(result["data"]["viewer"]["events"].count).to eq(1)
      expect(result["data"]["viewer"]["eventsAsParticipant"].count).to eq(1)
      expect(result["data"]["viewer"]["eventsAsParticipant"][0]["users"].count).to eq(1)
    end

    it "gets blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["chats"].count).to eq(1)


      expect(result["data"]["viewer"]["receivedLikes"].count).to eq(1)
      expect(result["data"]["viewer"]["sentLikes"].count).to eq(0)

      expect(result["data"]["viewer"]["events"].count).to eq(2)

      user_that_likes_me.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["data"]["viewer"]["id"]).to eq(user.id)
      expect(result["data"]["viewer"]["chats"].count).to eq(0)

      expect(result["data"]["viewer"]["receivedLikes"].count).to eq(0)
      expect(result["data"]["viewer"]["sentLikes"].count).to eq(0)

      expect(result["data"]["viewer"]["events"].count).to eq(1)
    end

    it "get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "profile field values" do
    let!(:profile_field_group) {
      FactoryBot.create :profile_field_group
    }
    let!(:restricted_profile_field) {
      FactoryBot.create :profile_field, {
        name: "restricted_profile_field",
        restricted: true,      
        profile_field_group: profile_field_group
      }
    }
  
    let!(:restricted_by_user_profile_field) {
      FactoryBot.create :profile_field, {
        name: "restricted_by_user_profile_field",
        restricted: false,
        profile_field_group: profile_field_group
      }
    }
  
    let!(:relaxed_by_user_profile_field) {
      FactoryBot.create :profile_field, {
        name: "relaxed_by_user_profile_field",
        restricted: true,
        profile_field_group: profile_field_group
      }
    }

    let(:user) {
      FactoryBot.create(:user)
    }

    before(:each) do
      user.set_default_restricted_profile_fields
      user.save!
      user.profile_field_values[restricted_profile_field.name] = "restricted_profile_field_value"
      user.profile_field_values[restricted_by_user_profile_field.name] = "restricted_by_user_profile_field_value"
      user.profile_field_values[relaxed_by_user_profile_field.name] = "relaxed_by_user_profile_field_value"
      user.restricted_profile_fields = user.restricted_profile_fields + ["restricted_by_user_profile_field"] - ["relaxed_by_user_profile_field"]
      user.save!
    end

    it "can get the proper visiblities" do
      result = HowlrSchema.execute(GET_VIEWER,
        context: { current_user: user }
      )

      profile_field_value_data = result["data"]["viewer"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_profile_field"
      end
      expect(profile_field_value_data["restricted"]).to eq(true)

      profile_field_value_data = result["data"]["viewer"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_by_user_profile_field"
      end
      expect(profile_field_value_data["restricted"]).to eq(true)

      profile_field_value_data = result["data"]["viewer"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "relaxed_by_user_profile_field"
      end
      expect(profile_field_value_data["restricted"]).to eq(false)
    end
  end

  context "invalid_params" do
    it "can not get viewer if not connected" do
      result = HowlrSchema.execute(GET_VIEWER)
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end
require 'rails_helper'

RSpec.describe 'Queries::ViewerQuery' do
  let!(:group_1) { FactoryBot.create :group }
  let!(:group_2) { FactoryBot.create :group }
  let!(:user) { FactoryBot.create :user, groups: [group_1] }
  let!(:user_i_like) {
    FactoryBot.create(:user, {
      groups: [group_1, group_2],
      hide_likes: false,
      hide_birthdate: false,
      hide_city: false,
      hide_not_common_groups: false,
      birthdate: 18.years.ago,
      likes_as_liker: [
        FactoryBot.build(:like, liked: user)
      ],
      likes_as_liked: [
        FactoryBot.build(:like, liker: user)
      ],
      localities: ["A", "B", "C"]
    })
  }
  let!(:user_that_dont_like_me) {
    FactoryBot.create(:user, {
      groups: [group_1, group_2],
      hide_likes: false,
      hide_birthdate: false,
      hide_city: false,
      hide_not_common_groups: false,
      birthdate: 18.years.ago,
      likes_as_liker: [
      ],
      likes_as_liked: [
        FactoryBot.build(:like, liker: user)
      ]
    })
  }
  let!(:restricted_user) {
    FactoryBot.create(:user, {
      groups: [group_1, group_2],
      hide_likes: true,
      hide_birthdate: true,
      hide_city: true,
      hide_not_common_groups: true,
      birthdate: 18.years.ago,
      likes_as_liker: [
        FactoryBot.build(:like, liked: user)
      ],
      likes_as_liked: [
        FactoryBot.build(:like, liker: user)
      ],
      localities: ["A", "B", "C"]
    })
  }

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

  before(:each) do
    user_i_like.set_default_restricted_profile_fields
    user_i_like.save!
    user_i_like.profile_field_values[restricted_profile_field.name] = "restricted_profile_field_value"
    user_i_like.profile_field_values[restricted_by_user_profile_field.name] = "restricted_by_user_profile_field_value"
    user_i_like.profile_field_values[relaxed_by_user_profile_field.name] = "relaxed_by_user_profile_field_value"
    user_i_like.restricted_profile_fields = user_i_like.restricted_profile_fields + ["restricted_by_user_profile_field"] - ["relaxed_by_user_profile_field"]
    user_i_like.save!

    user_that_dont_like_me.set_default_restricted_profile_fields
    user_that_dont_like_me.save!
    user_that_dont_like_me.profile_field_values[restricted_profile_field.name] = "restricted_profile_field_value"
    user_that_dont_like_me.profile_field_values[restricted_by_user_profile_field.name] = "restricted_by_user_profile_field_value"
    user_that_dont_like_me.profile_field_values[relaxed_by_user_profile_field.name] = "relaxed_by_user_profile_field_value"
    user_that_dont_like_me.restricted_profile_fields = user_that_dont_like_me.restricted_profile_fields + ["restricted_by_user_profile_field"] - ["relaxed_by_user_profile_field"]
    user_that_dont_like_me.save!
  end

  GET_USER = %{
    query getUser($id: ID!) {
      viewer {
        id
        user(id: $id) {
          id
          name
          avatarUrl
          avatarLargeUrl
          online
          groupIds
          genderIds
          matchKindIds
          sexualOrientationIds
          likedCount
          likersCount
          hideLikes
          age
          bio
          like
          dislike
          localities
          relationshipStatusId
          profileFieldValues {
            id
            name
            value
            restricted
          }
          pictures {
            id
            pictureUrl
            thumbnailUrl
            createdAt
          }
        }
      }
    }
  }

  context "valid_params" do
    it "can get user" do
      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: user_i_like.id }
      )
      expect(result["data"]["viewer"]["user"]["id"]).to eq(user_i_like.id)
      expect(result["data"]["viewer"]["user"]["name"]).to eq(user_i_like.name)
      expect(result["data"]["viewer"]["user"]["groupIds"].length).to eq(2)
      expect(result["data"]["viewer"]["user"]["likersCount"]).to eq(1)
      expect(result["data"]["viewer"]["user"]["likedCount"]).to eq(1)
      expect(result["data"]["viewer"]["user"]["age"]).to eq(18)
      expect(result["data"]["viewer"]["user"]["localities"]).to eq(["C", "B", "A"])

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("restricted_profile_field_value")

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_by_user_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("restricted_by_user_profile_field_value")

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "relaxed_by_user_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("relaxed_by_user_profile_field_value")
    end

    it "can get user that don't like me and profile fields are hidden" do
      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: user_that_dont_like_me.id }
      )
      expect(result["data"]["viewer"]["user"]["id"]).to eq(user_that_dont_like_me.id)
      expect(result["data"]["viewer"]["user"]["name"]).to eq(user_that_dont_like_me.name)

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("")

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "restricted_by_user_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("")

      profile_field_value_data = result["data"]["viewer"]["user"]["profileFieldValues"].find do |profile_field_value|
        profile_field_value["name"] == "relaxed_by_user_profile_field"
      end
      expect(profile_field_value_data["value"]).to eq("relaxed_by_user_profile_field_value")
    end

    it "can get restricted user" do
      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: restricted_user.id }
      )
      expect(result["data"]["viewer"]["user"]["id"]).to eq(restricted_user.id)
      expect(result["data"]["viewer"]["user"]["name"]).to eq(restricted_user.name)
      expect(result["data"]["viewer"]["user"]["groupIds"].length).to eq(1)
      expect(result["data"]["viewer"]["user"]["likersCount"]).to eq(nil)
      expect(result["data"]["viewer"]["user"]["likedCount"]).to eq(nil)
      expect(result["data"]["viewer"]["user"]["age"]).to eq(nil)
      expect(result["data"]["viewer"]["user"]["localities"]).to eq(["B", "A"])
    end

    it "block users" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: user_i_like.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "gets blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: user_i_like.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_USER,
        context: { current_user: user },
        variables: { id: user_i_like.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get viewer if not connected" do
      result = HowlrSchema.execute(GET_USER,
        variables: { id: user_i_like.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Queries::AppQuery' do
  let!(:user) { FactoryBot.create :user }

  let!(:group_category) { FactoryBot.create :group_category }
  let!(:group) { FactoryBot.create :group, group_category: group_category }
  let!(:changelog) { FactoryBot.create :changelog }
  let!(:faq_item) { FactoryBot.create :information_item, type: "FaqItem" }
  let!(:tos_item) { FactoryBot.create :information_item, type: "TosItem" }
  let!(:privacy_policy_item) { FactoryBot.create :information_item, type: "PrivacyPolicyItem" }
  let!(:gender) { FactoryBot.create :gender }
  let!(:sexual_orientation) { FactoryBot.create :sexual_orientation }
  let!(:relationship_status) { FactoryBot.create :relationship_status }
  let!(:match_kind) { FactoryBot.create :match_kind }
  let!(:event_category) { FactoryBot.create :event_category }
  let!(:profile_field_group) { FactoryBot.create :profile_field_group }
  let!(:profile_field) { FactoryBot.create :profile_field, profile_field_group: profile_field_group }

  GET_APP = %{
    {
      app {
        id
        name
        maximumUsersCount
        maximumNameLength
        maximumFieldsLength
        accountRemovalMonthsCount
        minimumAge
        locationChangeIntervalMinutes
        codeBotUsername
        eventsMaximumSearchableDistance
        eventsMaxPerWeek
        maximumJoinedGroupsCount
        changelogs {
          id
          body
        }
        groups {
          id
          name
          groupCategoryId
          usersCount
          createdAt
        }
        genders {
          id
          name
          label
        }
        sexualOrientations {
          id
          name
          label
        }
        relationshipStatuses {
          id
          name
          label
        }
        matchKinds {
          id
          name
          label
        }
        groupCategories {
          id
          label
          createdAt
        }
        eventCategories {
          id
          label
          system
          createdAt
        }
        profileFieldGroups {
          id
          label
          profileFields {
            id
            name
            label
            pattern
            regexp
            deepLinkPattern
            appStoreId
            playStoreId
          }
        }
        changelogs {
          id
          createdAt
        }
        faqItems {
          id
          createdAt
        }
        tosItems {
          id
          createdAt
        }
        privacyPolicyItems {
          id
          createdAt
        }
        websiteLink
        githubLink
      }
    }
  }

  context "valid_params" do
    it "can get app with user" do
      result = HowlrSchema.execute(GET_APP,
        context: { current_user: user },
      )
      expect(result["data"]["app"]["name"]).to eq("My app")
    end

    it "can get app without user" do
      result = HowlrSchema.execute(GET_APP)
      expect(result["data"]["app"]["name"]).to eq("My app")
    end
  end
end
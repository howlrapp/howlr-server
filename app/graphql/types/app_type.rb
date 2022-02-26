module Types
  class AppType < Types::BaseObject
    field :id, ID, null: false

    field :name, String, null: false

    field :genders, [Types::GenderType], null: false
    field :sexual_orientations, [Types::SexualOrientationType], null: false
    field :match_kinds, [Types::MatchKindType], null: false
    field :relationship_statuses, [Types::RelationshipStatusType], null: false
    field :profile_field_groups, [Types::ProfileFieldGroupType], null: false

    field :group_categories, [Types::GroupCategoryType], null: false
    field :groups, [Types::GroupType], null: false

    field :event_categories, [Types::EventCategoryType], null: false

    field :changelogs, [Types::ChangelogType], null: false
    field :faq_items, [Types::InformationItemType], null: false
    field :tos_items, [Types::InformationItemType], null: false
    field :privacy_policy_items, [Types::InformationItemType], null: false

    field :maximum_users_count, Integer, null: false
    field :maximum_fields_length, Integer, null: false
    field :maximum_name_length, Integer, null: false
    field :account_removal_months_count, Integer, null: false
    field :events_maximum_searchable_distance, Integer, null: false
    field :events_max_per_week, Integer, null: false
    field :minimum_age, Integer, null: false
    field :location_change_interval_minutes, Integer, null: false
    field :code_bot_username, String, null: false
    field :maximum_joined_groups_count, Integer, null: false
    field :website_link, String, null: true
    field :github_link, String, null: true

    def name
      Rails.configuration.app_name
    end

    def genders
      Gender.order(:order)
    end

    def sexual_orientations
      SexualOrientation.order(:order)
    end

    def match_kinds
      MatchKind.order(:order)
    end

    def relationship_statuses
      RelationshipStatus.order(:order)
    end

    def profile_field_groups
      ProfileFieldGroup.all
    end

    def group_categories
      GroupCategory.all
    end

    def groups
      Group.all
    end

    def event_categories
      EventCategory.all
    end

    def changelogs
      Changelog.order(created_at: :desc)
    end

    def faq_items
      FaqItem.all
    end

    def tos_items
      TosItem.all
    end

    def privacy_policy_items
      PrivacyPolicyItem.all
    end

    def maximum_users_count
      Rails.configuration.maximum_users_count
    end

    def maximum_fields_length
      Rails.configuration.maximum_fields_length
    end

    def maximum_name_length
      Rails.configuration.maximum_name_length
    end

    def account_removal_months_count
      Rails.configuration.account_removal_months_count
    end

    def events_maximum_searchable_distance
      Rails.configuration.events_maximum_searchable_distance
    end

    def events_max_per_week
      Rails.configuration.events_max_per_week
    end

    def minimum_age
      Rails.configuration.minimum_age
    end

    def location_change_interval_minutes
      Rails.configuration.location_change_interval_minutes
    end

    def code_bot_username
      Rails.configuration.code_bot_username
    end

    def maximum_joined_groups_count
      Rails.configuration.maximum_joined_groups_count
    end

    def website_link
      Rails.configuration.website_link
    end

    def github_link
      Rails.configuration.github_link
    end
  end
end

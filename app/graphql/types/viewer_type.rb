module Types
  class ViewerType < Types::UserType
    field :id, ID, null: false

    field :birthdate, String, null: true

    field :distance_unit, String, null: false
    field :latitude, Float, null: true
    field :longitude, Float, null: true

    field :hide_birthdate, Boolean, null: false
    field :hide_not_common_groups, Boolean, null: false

    field :chats, [Types::ChatType], null: false

    field :received_likes, [Types::LikeType], null: false
    field :sent_likes, [Types::LikeType], null: false

    field :events, [Types::EventType], null: false
    field :events_as_participant, [Types::EventType], null: false

    field :blocked_users, [Types::BlockedUserType], null: false

    field :profile_field_values, [Types::ProfileFieldValueType], null: false

    field :hide_city, Boolean, null: false
    field :share_online_status, Boolean, null: false
    field :hide_likes, Boolean, null: false

    field :sessions, [Types::SessionType], null: false

    field :allow_like_notification, Boolean, null: false
    field :allow_message_notification, Boolean, null: false
    field :allow_chat_notification, Boolean, null: false
    field :allow_event_created_notification, Boolean, null: false
    field :allow_event_joined_notification, Boolean, null: false

    field :maximum_searchable_distance, Integer, null: true

    field :can_change_location, Boolean, null: false
    field :can_create_event, Boolean, null: false

    field :chat, ChatType, null: false do
      argument :id, ID, required: true
    end

    field :user_summaries, [Types::UserSummaryType], null: false do
      argument :gender_ids, [String], required: false
      argument :sexual_orientation_ids, [String], required: false
      argument :relationship_status_ids, [String], required: false
      argument :group_ids, [String], required: false
      argument :event_ids, [String], required: false
      argument :match_kind_ids, [String], required: false
      argument :online, Boolean, required: false
      argument :recent, Boolean, required: false
      argument :age_ids, [String], required: false
      argument :liked_by_me, Boolean, required: false
      argument :liking_me, Boolean, required: false
      argument :q, String, required: false
    end

    field :user, UserType, null: false do
      argument :id, ID, required: true
    end

    field :event, EventType, null: false do
      argument :id, ID, required: true
    end

    field :group, GroupType, null: false do
      argument :id, ID, required: true
    end

    def user_summaries(
      gender_ids: nil,
      sexual_orientation_ids: nil,
      relationship_status_ids: nil,
      group_ids: nil,
      event_ids: nil,
      match_kind_ids: nil,
      recent: nil,
      online: nil,
      age_ids: nil,
      liked_by_me: nil,
      liking_me: nil,
      q: nil
    )
      raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], User.new).index?

      users = UserPolicy::Scope.new(context[:current_user], User.all).resolve

      if event_ids.blank?
        users = users.where("(users.last_seen_at > ? OR users.uuid = ?)", Rails.configuration.idle_days_count.days.ago, context[:current_user].uuid)
      end

      if q.present?
        users = users.where("f_unaccent(users.name) ILIKE unaccent(?)", "%#{q.strip}%")
      end

      if gender_ids.present?
        users = users.where("ARRAY[?]::varchar[] && users.gender_ids_cache", gender_ids)
      end

      if sexual_orientation_ids.present?
        users = users.where("ARRAY[?]::varchar[] && users.sexual_orientation_ids_cache", sexual_orientation_ids)
      end

      if relationship_status_ids.present?
        users = users.where("users.relationship_status_id IN (?)", relationship_status_ids)
      end

      if match_kind_ids.present?
        users = users.where("ARRAY[?]::varchar[] && users.match_kind_ids_cache", match_kind_ids)
      end

      if group_ids.present?
        users = users
          .where("ARRAY[?]::varchar[] <@ users.group_ids_cache", group_ids)
          .where("(users.hide_not_common_groups = ? OR ARRAY[?]::varchar[] && users.group_ids_cache)", false, context[:current_user].group_ids_cache & group_ids)
      end

      if event_ids.present?
        allowed_events = EventPolicy::Scope.new(context[:current_user], Event.where(uuid: event_ids)).resolve_for_query

        users = users
          .where("ARRAY[?]::varchar[] && users.events_as_participant_ids_cache", allowed_events.pluck(:uuid))
      end

      if age_ids.present?
        # Turn age ids into suitable list of ages
        ages = age_ids.map do |age_id|
          minimum_age, maximum_age = age_id.split("_").map(&:to_i)

          ([ minimum_age, Rails.configuration.minimum_age ].max..[ maximum_age, Rails.configuration.maximum_age ].min).to_a
        end.flatten
        users = users.where(age_cache: ages).where(hide_birthdate: false)
      end

      if online
        users = users.where("users.last_seen_at > ? AND users.share_online_status = ?", Rails.configuration.online_duration.minutes.ago, true)
      end

      if recent
        users = users.where("users.created_at > ?", Rails.configuration.recent_users_days_count.day.ago)
      end

      if liked_by_me
        users = users.where("ARRAY[?]::varchar[] <@ users.liker_ids_cache", context[:current_user].id)
      end

      if liking_me
        users = users.where("ARRAY[?]::varchar[] <@ users.liked_ids_cache", context[:current_user].id)
      end

      users = users.order(Arel.sql("users.lonlat <-> #{context[:current_user].geometry}"))

      users
        .select([
          :id,
          :uuid,
          :avatar,
          :name,
          :lonlat,
          :share_online_status,
          :last_seen_at,
          :updated_at,
          :system
        ])
        .limit(Rails.configuration.maximum_users_count)
    end

    def user(id:)
      User.find(id).tap do |user|
        raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], user).show?
      end
    end

    def latitude
      object.lonlat&.latitude
    end

    def longitude
      object.lonlat&.longitude
    end

    def birthdate
      object.birthdate&.iso8601
    end

    def online
      object.last_seen_at.present? && object.last_seen_at > Rails.configuration.online_duration.minutes.ago
    end

    def blocked_users
      User.select(:id, :uuid, :name).where(uuid: object.blocked_users_ids)
    end

    def chats
      ChatPolicy::Scope.new(context[:current_user], Chat.all)
        .resolve
        .includes(:preview_message)
    end

    def received_likes
      LikePolicy::Scope.new(context[:current_user], Like.all)
        .resolve
        .where("likes.liked_id = ?", context[:current_user].id)
        .order(created_at: :desc)
    end

    def sent_likes
      LikePolicy::Scope.new(context[:current_user], Like.all)
        .resolve
        .where("likes.liker_id = ?", context[:current_user].id)
        .order(created_at: :desc)
    end

    def events
      EventPolicy::Scope.new(context[:current_user], Event.all)
        .resolve
        .order(Arel.sql("events.lonlat <-> #{context[:current_user].geometry}"))
    end

    def event(id:)
      Event.find(id).tap do |event|
        raise Pundit::NotAuthorizedError unless EventPolicy.new(context[:current_user], event).show?
      end
    end

    def chat(id:)
      Chat.find(id).tap do |chat|
        raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).show?
      end
    end

    def can_change_location
      if object.location_changed_at.blank?
        true
      else
        object.location_changed_at < Rails.configuration.location_change_interval_minutes.minutes.ago
      end
    end

    def can_create_event
      EventPolicy.new(context[:current_user], Event.new).create?
    end

    def events_as_participant
      EventPolicy::Scope.new(context[:current_user], object.events_as_participant)
        .resolve_as_participant
        .order(date: :asc)
    end
  end
end

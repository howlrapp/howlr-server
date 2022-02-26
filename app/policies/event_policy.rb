class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      resolve_as_participant
        .where("events.date > ?", Rails.configuration.past_events_visibility_days_count.days.ago)
        .where("ST_DWithin(#{user.geometry}, events.lonlat, events.maximum_searchable_distance)")
    end

    def resolve_for_query
      # Allow the event if the user is either a participant or if they are in the event boundary
      resolve_as_participant
        .where("events.uuid IN (?) OR ST_DWithin(#{user.geometry}, events.lonlat, events.maximum_searchable_distance)", user.events_as_participant_ids_cache)
    end

    def resolve_as_participant
      scope
        .joins(:user)
        .where.not("? = SOME(users.blocked_users_ids)", user.uuid)
        .where.not(users: { uuid: user.blocked_users_ids })
        .where(%{
          events.privacy_status = 'open' OR
          events.user_id = ? OR
          (events.privacy_status = 'liked_only' AND ? = SOME(users.liked_ids_cache))
        }, user.uuid, user.uuid)
    end
  end

  def insert?
    user_is_valid? &&
      record.user == user &&
      record.event_category.system == false &&
      record.maximum_searchable_distance <= Rails.configuration.events_maximum_searchable_distance &&
      create?
  end

  def show?
    # I was a bit lazy here, but it should do the job just fine
    EventPolicy::Scope.new(user, Event.all).resolve_for_query.pluck(:uuid).include? record.id
  end

  def destroy?
    user_is_valid? && record.user == user
  end

  def join?
    user_is_valid? && record.user != user && privacy_status_is_respected? && UserPolicy.new(user, record.user).show?
  end

  def leave?
    user_is_valid? && record.user != user
  end

  def create?
    record.persisted? || Event.where(user: user).where("events.created_at > ?", 7.days.ago).count < Rails.configuration.events_max_per_week
  end

  def authorized_users
    recipients = User
      .where("ST_DWithin(#{record.geometry}, users.lonlat, ?)", record.maximum_searchable_distance)
      .where('users.uuid != ?', user.id)
      .where.not("? = SOME(users.blocked_users_ids)", user.uuid)
      .where.not(users: { uuid: user.blocked_users_ids })

    if record.privacy_status == 'liked_only'
      recipients = recipients.where(uuid: user.liked_ids_cache)
    end

    recipients
  end

  def privacy_status_is_respected?
    if record.privacy_status == "liked_only"
      record.user.liked_ids_cache.include?(user.id)
    else
      true
    end
  end
end

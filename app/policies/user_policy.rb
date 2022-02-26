class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.blank? || user.lonlat&.latitude.blank? || user.lonlat&.longitude.blank?

      scope.where.not("? = SOME(users.blocked_users_ids)", user.uuid)
        .where.not(uuid: user.blocked_users_ids)
        .where(state: "visible")
        .where(system: false)
        .where.not("users.karma < ? AND users.uuid != ?", Rails.configuration.karma_limit, user.uuid)
        .where("users.maximum_searchable_distance IS NULL OR ST_DWithin(#{user.geometry}, users.lonlat, users.maximum_searchable_distance)")
    end
  end

  def index?
    user_is_valid?
  end

  def update?
    user_is_valid? && record == user
  end

  def show?
    user_is_valid? && dont_have_ban?(record)
  end

  def destroy?
    update?
  end
end

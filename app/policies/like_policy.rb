class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .joins(:liker, :liked)
        .where("likes.liked_id = ? OR likes.liker_id = ?", user.id, user.id)
        .where.not("? = SOME(users.blocked_users_ids)", user.uuid)
        .where.not("? = SOME(likeds_likes.blocked_users_ids)", user.uuid)
        .where.not(users: { uuid: Array(user.blocked_users_ids) })
        .where.not(likeds_likes: { uuid: Array(user.blocked_users_ids) })
        .where.not("users.state = ?", "banned")
        .where.not("likeds_likes.state = ?", "banned")
        .where.not("users.karma < ? AND users.uuid != ?", Rails.configuration.karma_limit, user.id)
    end
  end

  def create?
    destroy? && UserPolicy.new(user, record.liked).show?
  end

  def destroy?
    record.liked.present? && UserPolicy.new(user, record.liker).update?
  end
end

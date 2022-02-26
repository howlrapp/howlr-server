class ChatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
        .joins(:recipient, :sender)
        .where("chats.recipient_id = ? OR chats.sender_id = ?", user.uuid, user.uuid)
        .where.not("? = SOME(users.blocked_users_ids)", user.uuid)
        .where.not("? = SOME(senders_chats.blocked_users_ids)", user.uuid)
        .where.not(users: { uuid: Array(user.blocked_users_ids) })
        .where.not(senders_chats: { uuid: Array(user.blocked_users_ids) })
        .where.not("users.state = ?", "banned")
        .where.not("senders_chats.state = ?", "banned")
        .where.not("senders_chats.karma < ? AND senders_chats.uuid != ?", Rails.configuration.karma_limit, user.id)
    end
  end

  def create?
    destroy? && UserPolicy.new(user, contact).show? && record.match_kind.present?
  end

  def show?
    create?
  end

  def read?
    create?
  end

  def accept?
    create? && record.recipient == user
  end

  def destroy?
    record.present? && UserPolicy.new(user, me).update?
  end

  def clear?
    destroy?
  end

  protected

  def me
    record.sender == user ? record.sender : record.recipient
  end

  def contact
    record.sender == user ? record.recipient : record.sender
  end
end

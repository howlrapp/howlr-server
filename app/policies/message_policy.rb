class MessagePolicy < ApplicationPolicy
  def destroy?
    ChatPolicy.new(user, record.chat).destroy?
  end

  def create?
    ChatPolicy.new(user, record.chat).create? &&
      UserPolicy.new(user, record.sender).update? &&
      record.chat.accepted_at.present?
  end
end

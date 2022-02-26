class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  protected

  def user_is_valid?
    user.present? && !user.is_banned?
  end

  def dont_have_ban?(other_user)
    other_user.present? && !user.blocked_users_ids.include?(other_user.id) && !other_user.blocked_users_ids.include?(user.id)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

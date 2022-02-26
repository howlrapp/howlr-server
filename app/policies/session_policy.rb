class SessionPolicy < ApplicationPolicy
  def show?
    record.present? && UserPolicy.new(user, record.user).update?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end

class PicturePolicy < ApplicationPolicy
  def create?
    UserPolicy.new(user, record.user).update?
  end

  def destroy?
    create?
  end
end

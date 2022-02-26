class ReportPolicy < ApplicationPolicy
  def create?
    UserPolicy.new(user, record.reporter).update?
  end
end

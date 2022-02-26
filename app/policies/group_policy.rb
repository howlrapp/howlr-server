class GroupPolicy < ApplicationPolicy
  def join?
    user_is_valid? && user.groups.count < Rails.configuration.maximum_joined_groups_count
  end

  def leave?
    user_is_valid?
  end
end

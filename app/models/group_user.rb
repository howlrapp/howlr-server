class GroupUser < ApplicationRecord
  self.primary_key = :uuid
  self.table_name = "groups_users"

  belongs_to :group, counter_cache: :users_count
  belongs_to :user, touch: true

  validates :user, uniqueness: { scope: :group }

  after_commit :update_ids_cache

  def update_ids_cache
    unless user.frozen?
      user.update(group_ids_cache: user.group_ids)
    end
  end
end

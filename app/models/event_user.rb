class EventUser < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :user
  belongs_to :event, counter_cache: :users_count

  validates :user, uniqueness: { scope: :event }

  after_commit :update_ids_cache

  def update_ids_cache
    unless user.frozen?
      user.update(events_as_participant_ids_cache: user.events_as_participant_ids)
    end
  end
end

class SexualOrientationUser < ApplicationRecord
  self.table_name = "sexual_orientations_users"
  self.primary_key = :uuid

  belongs_to :user, touch: true
  belongs_to :sexual_orientation

  validates :user, uniqueness: { scope: :sexual_orientation }
end

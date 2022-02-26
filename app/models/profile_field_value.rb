class ProfileFieldValue < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :user, touch: true
  belongs_to :profile_field

  validates :profile_field, presence: true, uniqueness: { scope: :user }
end

class ProfileField < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :profile_field_group, touch: true

  validates :name, presence: true, uniqueness: { scope: :profile_field_group }
  validates :label, presence: true, uniqueness: { scope: :profile_field_group }
end

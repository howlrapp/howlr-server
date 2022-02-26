class ProfileFieldGroup < ApplicationRecord
  self.primary_key = :uuid

  has_many :profile_fields, dependent: :destroy
  accepts_nested_attributes_for :profile_fields, allow_destroy: true

  validates :label, presence: true, uniqueness: true
end

class SexualOrientation < ApplicationRecord
  self.primary_key = :uuid

  has_many :sexual_orientation_users, dependent: :destroy
  has_many :users, through: :sexual_orientation_users

  validates :name, presence: true, uniqueness: true
end

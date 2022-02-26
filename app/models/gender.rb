class Gender < ApplicationRecord
  self.primary_key = :uuid

  has_many :gender_users, dependent: :destroy
  has_many :users, through: :gender_users

  validates :name, presence: true, uniqueness: true

  scope :sorted_genders, -> { order(:order) }
end

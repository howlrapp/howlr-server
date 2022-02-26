class Group < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :group_category, touch: true

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  validates :name, presence: true, uniqueness: { scope: :group_category }
end

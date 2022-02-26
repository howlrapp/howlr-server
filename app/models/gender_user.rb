class GenderUser < ApplicationRecord
  self.table_name = "genders_users"
  self.primary_key = :uuid

  belongs_to :user, touch: true
  belongs_to :gender

  validates :user, uniqueness: { scope: :gender }
end

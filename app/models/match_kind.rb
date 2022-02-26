class MatchKind < ApplicationRecord
  self.primary_key = :uuid

  has_many :chats, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

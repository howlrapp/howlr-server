class GroupCategory < ApplicationRecord
  self.primary_key = :uuid

  has_many :groups, dependent: :destroy

  validates :label, presence: true, uniqueness: true

  def name
    # :nocov:
    self.label
    # :nocov:
  end
end

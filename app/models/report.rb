class Report < ApplicationRecord
  self.primary_key = :uuid

  STATUSES = [ :new, :closed ]

  belongs_to :subject, polymorphic: true, optional: true, touch: true
  belongs_to :reporter, class_name: "User", optional: true

  validates :description, presence: true
end

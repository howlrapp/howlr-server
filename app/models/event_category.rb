class EventCategory < ApplicationRecord
  self.primary_key = :uuid

  def name
    #:nocov:
    label
    #:nocov:
  end

  has_many :events, dependent: :destroy
end

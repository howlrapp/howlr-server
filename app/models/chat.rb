class Chat < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :match_kind

  belongs_to :sender, class_name: "User", inverse_of: :chats_as_sender
  belongs_to :recipient, class_name: "User", inverse_of: :chats_as_recipient
  belongs_to :preview_message, class_name: "Message", optional: true

  has_many :messages, dependent: :destroy
  has_one :last_message, -> { order("messages.created_at DESC") }, class_name: "Message"
end

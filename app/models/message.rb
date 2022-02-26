class Message < ApplicationRecord
  self.primary_key = :uuid

  encrypts :body
  self.ignored_columns = ["body"]

  belongs_to :chat, touch: true
  belongs_to :sender, class_name: "User"

  after_create :mark_recipient_as_unread
  after_commit :set_preview_message, on: [:create, :destroy]

  mount_base64_uploader :picture, PictureUploader, mount_on: :picture, file_name: -> (u) { SecureRandom.uuid }

  def set_preview_message
    unless chat.frozen?
      chat.update(preview_message: chat.last_message)
    end
  end

  def mark_recipient_as_unread
    if sender_id == chat.sender_id
      chat.update(is_recipient_unread: true)
    elsif sender.id == chat.recipient_id
      chat.update(is_sender_unread: true)
    end
  end

  def recipient
    sender == chat.sender ? chat.recipient : chat.sender
  end
end

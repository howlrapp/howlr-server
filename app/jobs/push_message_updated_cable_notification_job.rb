class PushMessageUpdatedCableNotificationJob < ApplicationJob
  queue_as :default

  def perform(chat:, id:)
    MessageChannel.broadcast_to chat, { action: "updated", id: id }
  end
end

class PushChatUpdatedCableNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipient:, id:)
    ChatChannel.broadcast_to recipient, { action: "updated", id: id }
  end
end

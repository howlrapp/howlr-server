class PushLikeUpdatedCableNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipient:, id:)
    LikeChannel.broadcast_to recipient, { action: "updated", id: id }
  end
end

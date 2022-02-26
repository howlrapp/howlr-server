class PushEventUpdatedCableNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipient:, id:)
    EventChannel.broadcast_to recipient, { action: "updated", id: id }
  end
end

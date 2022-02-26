class Messages::NotifyDestroyedService
  attr_reader :message, :recipient

  def initialize(recipient:, message:)
    @recipient = recipient
    @message = message
  end

  def call
    notify_actioncable
  end

  private

  def notify_actioncable
    PushChatUpdatedCableNotificationJob.perform_later({
      recipient: @recipient,
      id: @message.chat.id
    })

    PushMessageUpdatedCableNotificationJob.perform_later({
      chat: @message.chat,
      id: @message.id
    })
  end
end

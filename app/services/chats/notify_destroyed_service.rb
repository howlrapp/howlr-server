class Chats::NotifyDestroyedService
  attr_reader :chat, :recipient

  def initialize(recipient:, chat:)
    @recipient = recipient
    @chat = chat
  end

  def call
    notify_actioncable
  end

  private

  def notify_actioncable
    PushChatUpdatedCableNotificationJob.perform_later({
      recipient: @recipient,
      id: @chat.id
    })
  end
end

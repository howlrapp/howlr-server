class Chats::NotifyAcceptedService
  attr_reader :chat, :recipient

  def initialize(recipient:, chat:)
    @recipient = recipient
    @chat = chat
  end

  def call
    notify_actioncable
    notify_expo
  end

  private

  def notify_actioncable
    PushChatUpdatedCableNotificationJob.set(wait: delay).perform_later({
      recipient: @recipient,
      id: @chat.id
    })
  end

  def notify_expo
    return unless @recipient.allow_chat_notification

    PushExpoNotificationJob.set(wait: delay).perform_later(
      tokens: @recipient.sessions.pluck(:expo_token),
      params: {
        body: "#{@chat.recipient.name} accepted your request",
        priority: 'high',
        channelId: 'chat',
        badge: @recipient.unread_chats_count,
        sound: 'default',
        data: {
          type: "chat:accepted",
          id: @chat.id,
        }
      }
    )
  end

  def delay
    Rails.configuration.notifications_delay.seconds
  end
end

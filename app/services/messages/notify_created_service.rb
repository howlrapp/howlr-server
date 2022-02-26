class Messages::NotifyCreatedService
  attr_reader :message, :recipient

  def initialize(recipient:, message:)
    @recipient = recipient
    @message = message
  end

  def call
    notify_actioncable
    notify_expo
  end

  private

  def notify_actioncable
    PushChatUpdatedCableNotificationJob.perform_later(
      recipient: @recipient,
      id: @message.chat.id
    )

    PushMessageUpdatedCableNotificationJob.perform_later(
      chat: @message.chat,
      id: @message.id
    )
  end

  def notify_expo
    return unless @recipient.allow_message_notification
    return if message.body.blank? && message.picture_url.blank?

    body =
      if message.body.present?
        message.body
      elsif message.picture_url.present?
        "Picture"
      end.truncate(2048)

    PushExpoNotificationJob.perform_later(
      tokens: @recipient.sessions.pluck(:expo_token),
      params: {
        body: body,
        title: @message.sender.name,
        priority: 'high',
        channelId: 'message',
        badge: @recipient.unread_chats_count,
        sound: 'default',
        data: {
          type: "message:created",
          id: @message.id,
          chat_id: @message.chat_id
        }
      }
    )
  end
end

class Likes::NotifyCreatedService
  attr_reader :like, :recipient

  def initialize(recipient:, like:)
    @recipient = recipient
    @like = like
  end

  def call
    notify_actioncable
    notify_expo
  end

  private

  def notify_actioncable
    PushLikeUpdatedCableNotificationJob.set(wait: delay).perform_later({
      recipient: @recipient,
      id: @like.id
    })
  end

  def notify_expo
    return unless @recipient.allow_like_notification

    PushExpoNotificationJob.set(wait: delay).perform_later(
      tokens: @recipient.sessions.pluck(:expo_token),
      params: {
        body: "#{@like.liker.name} liked your profile",
        priority: 'high',
        channelId: 'like',
        sound: 'default',
        data: {
          type: "like:created",
          id: @like.id
        }
      }
    )
  end

  def delay
    Rails.configuration.notifications_delay.seconds
  end
end

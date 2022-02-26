class Events::NotifyCreatedService
  attr_reader :event, :recipients

  def initialize(recipients:, event:)
    @recipients = recipients
    @event = event
  end

  def call
    notify_actioncable
    notify_expo
  end

  private

  def notify_actioncable
    @recipients.each do |recipient|
      PushEventUpdatedCableNotificationJob.set(wait: delay).perform_later({
        recipient: recipient,
        id: @event.id
      })
    end
  end

  def notify_expo
    @recipients.each do |recipient|
      next unless recipient.allow_event_created_notification

      PushExpoNotificationJob.set(wait: delay).perform_later(
        tokens: recipient.sessions.pluck(:expo_token),
        params: {
          body: "New event in your area: #{event.title}",
          priority: 'high',
          channelId: 'event',
          sound: 'default',
          data: {
            type: "event:created",
            id: @event.id
          }
        }
      )
    end
  end

  def delay
    Rails.configuration.notifications_delay.seconds
  end
end

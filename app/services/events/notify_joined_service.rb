class Events::NotifyJoinedService
  attr_reader :event, :recipient, :participant

  def initialize(recipient:, participant:, event:)
    @recipient = recipient
    @participant = participant
    @event = event
  end

  def call
    notify_actioncable
    notify_expo
  end

  private

  def notify_actioncable
    PushEventUpdatedCableNotificationJob.perform_later({
      recipient: @recipient,
      id: @event.id
    })
  end

  def notify_expo
    return unless @recipient.allow_event_joined_notification

    PushExpoNotificationJob.perform_later(
      tokens: @recipient.sessions.pluck(:expo_token),
      params: {
        body: "#{@participant.name} is going to your event",
        priority: 'high',
        channelId: 'event',
        sound: 'default',
        data: {
          type: "event:joined",
          id: @event.id
        }
      }
    )
  end
end

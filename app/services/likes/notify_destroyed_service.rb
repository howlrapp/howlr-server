class Likes::NotifyDestroyedService
  attr_reader :like, :recipient

  def initialize(recipient:, like:)
    @recipient = recipient
    @like = like
  end

  def call
    notify_actioncable
  end

  private

  def notify_actioncable
    PushLikeUpdatedCableNotificationJob.perform_later({
      recipient: @recipient,
      id: @like.id
    })
  end
end

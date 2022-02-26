class EventChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_session.user
  end
end

class MessageChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params["chatId"])
    raise Pundit::NotAuthorizedError unless ChatPolicy.new(current_session.user, chat).show?

    stream_for chat
  end
end

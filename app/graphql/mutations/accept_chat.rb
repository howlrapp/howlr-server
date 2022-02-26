class Mutations::AcceptChat < Mutations::BaseMutation
  argument :chat_id, ID, required: true

  field :chat, Types::ChatType, null: true

  def resolve(chat_id:)
    chat = Chat.find(chat_id)

    raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).accept?

    chat.update(accepted_at: DateTime.now)

    Chats::NotifyAcceptedService.new(recipient: chat.sender, chat: chat).call

    { chat: chat }
  end
end

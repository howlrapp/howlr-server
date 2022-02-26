class Mutations::ClearChat < Mutations::BaseMutation
  argument :chat_id, ID, required: true

  field :chat, Types::ChatType, null: false

  def resolve(chat_id:)
    chat = Chat.find(chat_id)

    raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).clear?

    chat.messages.destroy_all

    Chats::NotifyClearedService.new(
      recipient: context[:current_user] == chat.recipient ? chat.sender : chat.recipient,
      chat: chat
    ).call

    { chat: chat }
  end
end

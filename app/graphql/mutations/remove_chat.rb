class Mutations::RemoveChat < Mutations::BaseMutation
  argument :chat_id, ID, required: true

  field :id, ID, null: false

  def resolve(chat_id:)
    chat = Chat.find(chat_id)

    raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).destroy?

    chat.destroy!

    Chats::NotifyDestroyedService.new(
      recipient: context[:current_user] == chat.recipient ? chat.sender : chat.recipient,
      chat: chat
    ).call


    { id: chat.id }
  end
end

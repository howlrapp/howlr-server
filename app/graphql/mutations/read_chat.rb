class Mutations::ReadChat < Mutations::BaseMutation
  argument :chat_id, ID, required: true

  field :chat, Types::ChatType, null: true

  def resolve(chat_id:)
    chat = Chat.find(chat_id)

    raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).read?

    if context[:current_user].id == chat.sender_id
      chat.update!(is_sender_unread: false)
    else
      chat.update!(is_recipient_unread: false)
    end

    { chat: chat }
  end
end

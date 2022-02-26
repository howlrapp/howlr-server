class Mutations::RemoveMessage < Mutations::BaseMutation
  argument :message_id, ID, required: true

  field :id, ID, null: false

  def resolve(message_id:)
    message = Message.find(message_id)

    raise Pundit::NotAuthorizedError unless MessagePolicy.new(context[:current_user], message).destroy?

    message.destroy!

    Messages::NotifyDestroyedService.new(
      recipient: context[:current_user] == message.chat.recipient ? message.chat.sender : message.chat.recipient,
      message: message
    ).call

    { id: message.id }
  end
end

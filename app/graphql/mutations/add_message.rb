class Mutations::AddMessage < Mutations::BaseMutation
  argument :chat_id, ID, required: true
  argument :body, String, required: false
  argument :picture_url, String, required: false

  field :message, Types::MessageType, null: true

  def resolve(chat_id:, body: nil, picture_url: nil)
    message = Message.new(
      sender: context[:current_user],
      picture: picture_url,
      body: body,
      chat_id: chat_id
    )

    raise Pundit::NotAuthorizedError unless MessagePolicy.new(context[:current_user], message).create?

    message.save!

    if context[:current_user].karma_ok?
      Messages::NotifyCreatedService.new(recipient: message.recipient, message: message).call
    end

    { message: message }
  end
end

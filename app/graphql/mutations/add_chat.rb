class Mutations::AddChat < Mutations::BaseMutation
  argument :recipient_id, ID, required: true
  argument :match_kind_id, ID, required: true

  field :chat, Types::ChatType, null: true

  def resolve(recipient_id:, match_kind_id:)
    # If we have another chat with the same participant but the other way around,
    # we use it instead.
    chat_from_recipient = Chat.find_by(
      sender_id: recipient_id,
      recipient_id: context[:current_user]
    )
    if chat_from_recipient.present?
      raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat_from_recipient).show?

      return { chat: chat_from_recipient }
    end

    chat = Chat.find_or_initialize_by(
      sender: context[:current_user],
      recipient_id: recipient_id
    ) do |chat|
      chat.match_kind_id = match_kind_id
    end

    raise Pundit::NotAuthorizedError unless ChatPolicy.new(context[:current_user], chat).create?

    chat.save!

    if context[:current_user].karma_ok?
      Chats::NotifyCreatedService.new(recipient: chat.recipient, chat: chat).call
    end

    { chat: chat }
  end
end

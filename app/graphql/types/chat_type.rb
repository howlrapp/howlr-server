module Types
  class ChatType < Types::BaseObject
    field :id, ID, null: false
    field :match_kind_id, ID, null: false

    field :sender_id, ID, null: false
    field :recipient_id, ID, null: false

    field :contact, Types::UserSummaryType, null: false
    field :unread, Boolean, null: false

    field :created_at, String, null: false
    field :updated_at, String, null: false
    field :accepted_at, String, null: true

    field :preview_message, Types::MessageType, null: true
    field :messages, [Types::MessageType], null: false

    def updated_at
      object.updated_at&.iso8601
    end

    def created_at
      object.created_at&.iso8601
    end

    def accepted_at
      object.accepted_at&.iso8601
    end

    def contact
      if context[:current_user].id == object.recipient_id
        object.sender
      else
        object.recipient
      end
    end

    def unread
      if context[:current_user].id == object.recipient_id
        object.is_recipient_unread
      else
        object.is_sender_unread
      end
    end

    def messages
      object.messages.order(created_at: :desc)
    end
  end
end

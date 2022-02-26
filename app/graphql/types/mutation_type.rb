module Types
  class MutationType < Types::BaseObject
    field :update_viewer, mutation: Mutations::UpdateViewer
    field :update_session, mutation: Mutations::UpdateSession
    field :remove_session, mutation: Mutations::RemoveSession

    field :join_group, mutation: Mutations::JoinGroup
    field :leave_group, mutation: Mutations::LeaveGroup

    field :add_picture, mutation: Mutations::AddPicture
    field :remove_picture, mutation: Mutations::RemovePicture

    field :remove_avatar, mutation: Mutations::RemoveAvatar

    field :set_profile_field_value, mutation: Mutations::SetProfileFieldValue

    field :add_chat, mutation: Mutations::AddChat
    field :remove_chat, mutation: Mutations::RemoveChat
    field :accept_chat, mutation: Mutations::AcceptChat
    field :read_chat, mutation: Mutations::ReadChat
    field :clear_chat, mutation: Mutations::ClearChat

    field :add_message, mutation: Mutations::AddMessage
    field :remove_message, mutation: Mutations::RemoveMessage

    field :add_report, mutation: Mutations::AddReport

    field :add_like, mutation: Mutations::AddLike
    field :remove_like, mutation: Mutations::RemoveLike

    field :remove_account, mutation: Mutations::RemoveAccount

    field :remove_event, mutation: Mutations::RemoveEvent
    field :insert_event, mutation: Mutations::InsertEvent

    field :join_event, mutation: Mutations::JoinEvent
    field :leave_event, mutation: Mutations::LeaveEvent
  end
end

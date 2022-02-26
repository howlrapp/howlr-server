class Mutations::UpdateViewer < Mutations::BaseMutation
  argument :name, String, required: false
  argument :bio, String, required: false
  argument :like, String, required: false
  argument :dislike, String, required: false
  argument :gender_ids, [ID], required: false
  argument :sexual_orientation_ids, [ID], required: false
  argument :match_kind_ids, [ID], required: false
  argument :group_ids, [ID], required: false
  argument :blocked_users_ids, [ID], required: false
  argument :relationship_status_id, ID, required: false
  argument :avatar_url, String, required: false
  argument :latitude, Float, required: false
  argument :longitude, Float, required: false
  argument :birthdate, String, required: false
  argument :hide_birthdate, Boolean, required: false
  argument :auto_accept_chats, Boolean, required: false
  argument :hide_not_common_groups, Boolean, required: false
  argument :hide_likes, Boolean, required: false
  argument :share_online_status, Boolean, required: false
  argument :hide_city, Boolean, required: false
  argument :maximum_searchable_distance, Integer, required: false
  argument :distance_unit, String, required: false

  argument :allow_chat_notification, Boolean, required: false
  argument :allow_message_notification, Boolean, required: false
  argument :allow_like_notification, Boolean, required: false
  argument :allow_event_joined_notification, Boolean, required: false
  argument :allow_event_created_notification, Boolean, required: false

  field :viewer, Types::ViewerType, null: true

  def resolve(arguments = {})
    user = context[:current_user]

    base64_avatar = arguments.delete(:avatar_url)
    user.assign_attributes(arguments.merge({ avatar: base64_avatar }))

    raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], user).update?

    user.save!

    { viewer: user.reload }
  end
end

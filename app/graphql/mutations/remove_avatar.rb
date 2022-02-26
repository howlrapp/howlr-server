class Mutations::RemoveAvatar < Mutations::BaseMutation
  field :viewer, Types::ViewerType, null: true

  def resolve
    user = context[:current_user]
    raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], user).update?

    user.remove_avatar!
    user.save!

    { viewer: user.reload }
  end
end

class Mutations::RemoveAccount < Mutations::BaseMutation
  field :id, ID, null: false

  def resolve
    user = context[:current_user]

    raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], user).destroy?

    Users::RemoveAccountJob.perform_later(user: user)

    { id: user.id }
  end
end

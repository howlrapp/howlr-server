class Mutations::JoinGroup < Mutations::BaseMutation
  argument :group_id, ID, required: true

  field :group, Types::GroupType, null: true

  def resolve(group_id:)
    group = Group.find(group_id)

    raise Pundit::NotAuthorizedError unless GroupPolicy.new(context[:current_user], group).join?

    group.users.push context[:current_user]

    { group: group }
  end
end

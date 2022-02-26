class Mutations::RemoveSession < Mutations::BaseMutation
  argument :session_id, ID, required: false

  field :id, ID, null: false

  def resolve(session_id: nil)
    session = session_id.present? ? Session.find_by(uuid: session_id) : context[:current_session]

    raise Pundit::NotAuthorizedError unless SessionPolicy.new(context[:current_user], session).destroy?

    session.destroy!

    { id: session.id }
  end
end

class Mutations::UpdateSession < Mutations::BaseMutation
  argument :expo_token, String, required: false
  argument :version, Integer, required: false
  argument :device, String, required: false

  field :session, Types::SessionType, null: true

  def resolve(arguments = {})
    session = context[:current_session]
    session.assign_attributes arguments.merge(ip: context[:ip])

    raise Pundit::NotAuthorizedError unless SessionPolicy.new(context[:current_user], session).update?

    session.save!

    { session: session }
  end
end

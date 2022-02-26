class Mutations::LeaveEvent < Mutations::BaseMutation
  argument :event_id, ID, required: true

  field :event, Types::EventType, null: true

  def resolve(event_id:)
    event = Event.find(event_id)

    raise Pundit::NotAuthorizedError unless EventPolicy.new(context[:current_user], event).leave?

    event.users.destroy context[:current_user]

    { event: event }
  end
end

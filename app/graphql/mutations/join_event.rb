class Mutations::JoinEvent < Mutations::BaseMutation
  argument :event_id, ID, required: true

  field :event, Types::EventType, null: true

  def resolve(event_id:)
    event = Event.find(event_id)

    raise Pundit::NotAuthorizedError unless EventPolicy.new(context[:current_user], event).join?

    event.users.push context[:current_user]

    Events::NotifyJoinedService.new(recipient: event.user, participant: context[:current_user], event: event).call

    { event: event }
  end
end

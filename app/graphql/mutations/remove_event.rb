class Mutations::RemoveEvent < Mutations::BaseMutation
  argument :event_id, ID, required: true

  field :id, ID, null: false

  def resolve(event_id:)
    event = Event.find(event_id)

    raise Pundit::NotAuthorizedError unless EventPolicy.new(context[:current_user], event).destroy?

    event.destroy!

    { id: event.id }
  end
end

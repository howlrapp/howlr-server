class Mutations::InsertEvent < Mutations::BaseMutation
  argument :id, ID, required: false
  argument :event_category_id, ID, required: true
  argument :title, String, required: true
  argument :privacy_status, String, required: true
  argument :address, String, required: true
  argument :description, String, required: false
  argument :date, String, required: true
  argument :latitude, Float, required: true
  argument :longitude, Float, required: true
  argument :maximum_searchable_distance, Integer, required: true

  field :event, Types::EventType, null: true

  def resolve(
    id: nil,
    event_category_id:,
    title:,
    privacy_status:,
    address:,
    description: nil,
    date:,
    latitude:,
    longitude:,
    maximum_searchable_distance:
  )
    event = Event.find_or_initialize_by(uuid: id) do |event|
      event.user = context[:current_user]
    end

    event.assign_attributes(
      event_category_id: event_category_id,
      title: title,
      address: address,
      privacy_status: privacy_status,
      description: description,
      date: date,
      latitude: latitude,
      longitude: longitude,
      maximum_searchable_distance: maximum_searchable_distance
    )

    raise Pundit::NotAuthorizedError unless EventPolicy.new(context[:current_user], event).insert?

    event.save!

    # add current_user to participants
    event.users.push context[:current_user].reload

    # Notify people around when the event is created
    if id.blank?
      recipients = EventPolicy.new(context[:current_user], event).authorized_users

      Events::NotifyCreatedService.new(recipients: recipients, event: event).call
    end

    { event: event }
  end
end

module Types
  class EventCategoryType < Types::BaseObject
    field :id, ID, null: false

    field :system, Boolean, null: false

    field :label, String, null: false
    field :created_at, String, null: false
  end
end

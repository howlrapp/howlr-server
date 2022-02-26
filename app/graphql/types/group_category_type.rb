module Types
  class GroupCategoryType < Types::BaseObject
    field :id, ID, null: false

    field :label, String, null: false
    field :created_at, String, null: false
  end
end

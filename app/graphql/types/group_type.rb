module Types
  class GroupType < Types::BaseObject
    field :id, ID, null: false

    field :name, String, null: false
    field :users_count, Integer, null: false
    field :group_category_id, ID, null: false
    field :created_at, String, null: false

    def created_at
      object.created_at&.iso8601
    end
  end
end

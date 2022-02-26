module Types
  class MatchKindType < Types::BaseObject
    field :id, ID, null: false

    field :name, String, null: false
    field :label, String, null: false
    field :created_at, String, null: false
  end
end

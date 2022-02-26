module Types
  class ProfileFieldGroupType < Types::BaseObject
    field :id, ID, null: false

    field :label, String, null: false
    field :order, Integer, null: false

    field :profile_fields, [Types::ProfileFieldType], null: false
  end
end

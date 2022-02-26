module Types
  class ProfileFieldType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :label, String, null: false
    field :pattern, String, null: true
    field :regexp, String, null: true
    field :deep_link_pattern, String, null: true
    field :app_store_id, String, null: true
    field :play_store_id, String, null: true
  end
end

module Types
  class ChangelogType < Types::BaseObject
    field :id, ID, null: false

    field :body, String, null: false
    field :created_at, String, null: false

    def created_at
      object.created_at&.iso8601
    end
  end
end

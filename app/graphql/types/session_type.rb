module Types
  class SessionType < Types::BaseObject
    field :id, ID, null: false
    field :expo_token, String, null: true
    field :ip, String, null: true
    field :version, Integer, null: true
    field :created_at, String, null: false
    field :last_seen_at, String, null: true
    field :device, String, null: true

    def created_at
      object.created_at&.iso8601
    end

    def last_seen_at
      object.last_seen_at&.iso8601
    end
  end
end

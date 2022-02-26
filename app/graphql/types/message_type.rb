module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :sender_id, ID, null: false

    field :body, String, null: true
    field :created_at, String, null: false

    field :picture_url, String, null: true
    field :thumbnail_url, String, null: true

    def created_at
      object.created_at&.iso8601
    end

    def picture_url
     object.picture_url(:full)
    end

    def thumbnail_url
      object.picture_url(:thumbnail)
    end
  end
end

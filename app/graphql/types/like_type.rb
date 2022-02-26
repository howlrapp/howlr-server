module Types
  class LikeType < Types::BaseObject
    field :id, ID, null: false

    field :user, Types::UserSummaryType, null: false

    field :created_at, String, null: false

    def created_at
      object.created_at&.iso8601
    end

    def user
      context[:current_user].id == object.liked_id ? object.liker : object.liked
    end
  end
end

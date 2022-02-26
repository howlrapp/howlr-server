module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false

    field :event_category_id, ID, null: false

    field :user, Types::UserSummaryType, null: true
    field :users, [Types::UserSummaryType], null: false
    field :users_count, Integer, null: false

    field :title, String, null: false
    field :address, String, null: false
    field :description, String, null: true

    field :privacy_status, String, null: true

    field :date, String, null: false

    field :localities, [String], null: false

    field :created_at, String, null: false
    field :updated_at, String, null: false

    def updated_at
      object.updated_at&.iso8601
    end

    def created_at
      object.created_at&.iso8601
    end

    def date
      object.date&.iso8601
    end

    def localities
      (object.localities || []).reverse
    end

    def users
      UserPolicy::Scope.new(object.user, object.users).resolve
    end
  end
end

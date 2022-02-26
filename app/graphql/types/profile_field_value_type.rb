module Types
  class ProfileFieldValueType < Types::BaseObject
  	field :id, ID, null: false

    field :name, String, null: false
    field :value, String, null: false
    field :restricted, Boolean, null: false

    def id
      "#{object[:user].id}-#{object[:name]}"
    end

    def value
      if object[:user] == context[:current_user]
        object[:value]
      elsif object[:restricted]
        object[:user].liked_ids_cache.include?(context[:current_user].id) ? object[:value] : ""
      else
        object[:value]
      end
    end
  end
end

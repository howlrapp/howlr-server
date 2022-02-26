module Types
  class UserType < UserSummaryType
    field :name, String, null: false
    field :bio, String, null: true
    field :like, String, null: true
    field :dislike, String, null: true

    field :avatar_large_url, String, null: true

    field :relationship_status_id, ID, null: true
    field :match_kind_ids, [ID], null: false
    field :gender_ids, [ID], null: false
    field :sexual_orientation_ids, [ID], null: false
    field :group_ids, [ID], null: false

    field :profile_field_values, [Types::ProfileFieldValueType], null: false

    field :likers_count, Integer, null: true
    field :liked_count, Integer, null: true

    field :hide_likes, Boolean, null: false

    field :age, Integer, null: true

    field :pictures, [Types::PictureType], null: false

    field :localities, [String], null: false

    def avatar_large_url
      object.avatar_url(:large)
    end

    def match_kind_ids
      object.match_kind_ids_cache
    end

    def gender_ids
      object.gender_ids_cache
    end

    def sexual_orientation_ids
      object.sexual_orientation_ids_cache
    end

    def likers_count
      if object == context[:current_user] || !object.hide_likes
        object.likers_count
      else
        nil
      end
    end

    def liked_count
      if object == context[:current_user] || !object.hide_likes
        object.liked_ids_cache.count
      else
        nil
      end
    end

    def profile_field_values
      ProfileField.find_each.map do |profile_field|
        {
          name: profile_field.name,
          value: String(object.profile_field_values[profile_field.name]),
          restricted: object.restricted_profile_fields.include?(profile_field.name),
          user: object,
          profile_field: profile_field
        }
      end
    end

    def group_ids
      if object.hide_not_common_groups?
        object.group_ids_cache & context[:current_user].group_ids_cache
      else
        object.group_ids_cache
      end
    end

    def age
      if (object.birthdate.blank? || object.hide_birthdate?) && object != context[:current_user]
        nil
      else
        object.age_cache
      end
    end

    def localities
      if object.hide_city? && object != context[:current_user]
        object.localities[0..1]
      else
        object.localities
      end.reverse
    end
  end
end

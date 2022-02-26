class Mutations::SetProfileFieldValue < Mutations::BaseMutation
  argument :name, String, required: true
  argument :value, String, required: true
  argument :restricted, Boolean, required: false

  field :profile_field_value, Types::ProfileFieldValueType, null: false

  def resolve(name:, value:, restricted: nil)
    user = context[:current_user]
    user.profile_field_values[name] = value

    if restricted
      user.restricted_profile_fields += [name]
    elsif restricted == false  # restricted can be nil
      user.restricted_profile_fields -= [name]
    end

    raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], user).update?

    user.save!

    {
      profile_field_value: {
        name: name,
        value: value,
        restricted: context[:current_user].restricted_profile_fields.include?(name),
        user: context[:current_user],
      }
    }
  end
end

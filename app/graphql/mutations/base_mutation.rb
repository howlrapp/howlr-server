class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  def ready?(**args)
    # Globally disallow public mutations
    raise Pundit::NotAuthorizedError if context[:current_user].blank?
    true
  end

end

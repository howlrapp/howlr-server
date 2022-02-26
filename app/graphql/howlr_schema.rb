class HowlrSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  rescue_from ActiveRecord::RecordInvalid do |exception|
    GraphQL::ExecutionError.new(exception.record.errors.full_messages.join("\n"))
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    GraphQL::ExecutionError.new("Not found")
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    GraphQL::ExecutionError.new("Not authorized")
  end
end

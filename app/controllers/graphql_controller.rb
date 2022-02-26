class GraphqlController < ActionController::Metal
  def execute
    self.response_body = HowlrSchema.execute(params[:query],
      variables: params[:variables],
      context: {
        current_user: current_session&.user,
        current_session: current_session,
        ip: String(request.remote_ip).split().last
      },
      operation_name: params[:operationName]
    ).to_json
    self.content_type = "application/json"
  end

  private

  def current_session
    @current_session ||= Session.find_by(uuid: request.headers["Authorization"]&.split(" ").try(:[], 1))
  end
end

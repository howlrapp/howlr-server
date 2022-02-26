class PushExpoNotificationJob < ApplicationJob
  queue_as :default

  def perform(tokens:, params:)
    valid_tokens = tokens.compact.uniq
    Exponent::Push::Client.new.send_messages([ params.merge(to: valid_tokens) ]) if valid_tokens.any?
  rescue Exponent::Push::UnknownError
    # ignore those errors
  end
end

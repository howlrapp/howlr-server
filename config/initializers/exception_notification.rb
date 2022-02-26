require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  config.ignored_exceptions += %w{ActiveJob::DeserializationError OpenURI::HTTPError Net::OpenTimeout}

  config.add_notifier :database, -> (exception, options) {
    Error.create(exception: exception, backtrace: exception.backtrace)
  }
end

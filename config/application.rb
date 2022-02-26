require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "active_storage/engine"
# require "action_mailbox/engine"
# require "action_text/engine"
require "rails/test_unit/railtie"

require 'fog/aws'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Howlr
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.action_cable.mount_path = '/cable/:token'
    config.action_cable.disable_request_forgery_protection = true
    config.action_cable.worker_pool_size = 4
    config.action_cable.allowed_request_origins = "*"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.app_name = ENV["APP_NAME"] || "My app"

    config.secret_key_base = ENV["SECRET_KEY_BASE"]

    config.website_link = ENV["WEBSITE_LINK"]
    config.github_link = ENV["GITHUB_LINK"]

    config.maximum_users_count = (ENV["MAXIMUM_USERS_COUNT"] || 1000).to_i
    config.idle_days_count = (ENV["IDLE_DAYS_COUNT"] || 30).to_i
    config.recent_users_days_count = (ENV["RECENT_USERS_DAYS_COUNT"] || 2).to_i
    config.account_removal_months_count = (ENV["ACCOUNT_REMOVAL_MONTHS_COUNT"] || 15).to_i
    config.minimum_age = (ENV["MINIMUM_AGE"] || 18).to_i
    config.maximum_age = (ENV["MAXIMUM_AGE"] || 150).to_i
    config.online_duration = (ENV["ONLINE_DURATION"] || 5).to_i
    config.location_change_interval_minutes = (ENV["LOCATION_CHANGE_INTERVAL_MINUTES"] || 60).to_i
    config.past_events_visibility_days_count = (ENV["PAST_EVENTS_VISIBLITY_DAYS_COUNT"] || 7).to_i
    config.events_maximum_searchable_distance = (ENV["EVENT_MAXIMUM_SEARCHABLE_DISTANCE"] || 100000).to_i
    config.events_max_per_week = (ENV["EVENTS_MAX_PER_WEEK"] || 3).to_i
    config.maximum_joined_groups_count = (ENV["MAXIMUM_JOINED_GROUPS_COUNT"] || 60).to_i

    config.maximum_fields_length = (ENV["MAXIMUM_FIELDS_LENGTH"] || 4000).to_i
    config.maximum_name_length = (ENV["MAXIMUM_NAME_LENGTH"] || 100).to_i
    config.code_length = (ENV["CODE_LENGTH"] || 6).to_i
    config.code_expiration_delay = (ENV["CODE_EXPIRATION_DELAY"] || 60).to_i
    config.notifications_delay = (ENV["NOTIFICATIONS_DELAY"] || 1).to_i

    config.karma_limit = (ENV["KARMA_LIMIT"] || -8).to_i

    config.s3_access_key_id = ENV["S3_ACCESS_KEY_ID"]
    config.s3_secret_access_key = ENV["S3_SECRET_ACCESS_KEY"]
    config.s3_bucket = ENV["S3_BUCKET"]
    config.s3_endpoint = ENV["S3_ENDPOINT"]
    config.s3_region = ENV["S3_REGION"]
    config.s3_host = ENV["S3_HOST"]

    config.asset_host = ENV["ASSET_HOST"]

    config.code_bot_username = ENV["CODE_BOT_USERNAME"]
    config.code_bot_token = ENV["CODE_BOT_TOKEN"]

    config.apple_sign_up_code = ENV["APPLE_SIGN_UP_CODE"]

    config.avatar_tiny_size = (ENV["AVATAR_TINY_SIZE"] || 112).to_i
    config.avatar_large_size = (ENV["AVATAR_LARGE_SIZE"] || 200).to_i

    config.picture_full_width = (ENV["PICTURE_FULL_WIDTH"] || 1080).to_i
    config.picture_full_height = (ENV["PICTURE_FULL_HEIGHT"] || 1465).to_i
    config.picture_thumbnail_size = (ENV["PICTURE_THUMBNAIL_SIZE"] || 200).to_i

    config.remove_original_file = ENV["REMOVE_ORIGINAL_FILE"] == 'true'

    # For ActiveAdmin and Devise
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.autoload_paths += %W(#{config.root}/app/services/**/*)
    config.autoload_paths += %W(#{config.root}/app/helpers/**/*)
    config.autoload_paths += %W(#{config.root}/app/graphql/loaders/*)

    config.generators do |g|
      g.test_framework :rspec
      g.factory_bot dir: 'spec/factories'
    end
  end
end

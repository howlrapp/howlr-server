ActiveAdmin.setup do |config|
  config.site_title = "#{Rails.configuration.app_name} Admin"
  config.default_namespace = ENV["ACTIVEADMIN_DEFAULT_NAMESPACE"] || "admin"

  config.root_to = 'reports#index'

  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = true

  config.localize_format = :short
  config.breadcrumb = true
  config.default_per_page = 30

  # From https://github.com/cprodhomme/arctic_admin
  meta_tags_options = { viewport: 'width=device-width, initial-scale=1' }
  config.meta_tags = meta_tags_options
  config.meta_tags_for_logged_out_pages = meta_tags_options
end

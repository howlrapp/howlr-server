ActiveAdmin.register_page "Dashboard" do

  blacklisted_envs = [
    "SECRET_KEY_BASE",
    "CODE_BOT_TOKEN",
    "SECRET_ACCESS_KEY", 
    "DATABASE_URL",
    "REDIS_URL",
    "APPLE_SIGN_UP_CODE",
    "DOKKU",
    "BUNDLER",
    "PATH"
  ]

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content do
    tabs do
      tab :configuration do
        [
          :app_name,
          :website_link,
          :github_link,
          :maximum_users_count,
          :idle_days_count,
          :recent_users_days_count,
          :account_removal_months_count,
          :minimum_age,
          :maximum_age,
          :online_duration,
          :location_change_interval_minutes,
          :past_events_visibility_days_count,
          :events_maximum_searchable_distance,
          :events_max_per_week,
          :maximum_joined_groups_count,
          :maximum_fields_length,
          :maximum_name_length,
          :code_length,
          :code_expiration_delay,
          :notifications_delay,
          :karma_limit,
          :s3_access_key_id,
          :s3_bucket,
          :s3_endpoint,
          :s3_region,
          :s3_host,
          :asset_host,
          :code_bot_username,
          :avatar_tiny_size,
          :avatar_large_size,
          :picture_full_width,
          :picture_full_height,
          :picture_thumbnail_size,
          :remove_original_file
        ].each do |configuration_item|
          panel configuration_item.upcase, style: "font-size: 0.6em; padding-bottom: 2em" do
            input value: Rails.configuration.send(configuration_item).to_s, id: configuration_item, disabled: true
          end
        end    
      end

      tab :activity do
        columns do
          column do
            [
              User,
              Chat,
              Event
            ].each do |model|
              panel "New #{model.table_name} by day" do
                line_chart model.group_by_day(:created_at).count, download: true
              end
              br
              br
              br
            end
          end
        end
      end
    end
  end
end

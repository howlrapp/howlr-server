ActiveAdmin.register User do
  config.sort_order = 'created_at_desc'
  actions :index, :create, :edit, :update, :destroy

  controller do
    def permitted_params
      params.permit(:_method, :authenticity_token, :id, :commit, user: [
        :name,
        :state,
        :avatar,
        :karma_boost,
        :telegram_username,
        :telegram_id,
        :bio,
        :like,
        :dislike,
        :hide_likes,
        :birthdate,
        :latitude,
        :longitude,
        :maximum_searchable_distance,
        :location_changed_at,
        :hide_city,
        :allow_chat_notification,
        :allow_message_notification,
        :allow_like_notification,
        :allow_event_created_notification,
        :allow_event_joined_notification,
        profile_field_values: ProfileField.pluck(:name),
        pictures_attributes: [
          :id,
          :_destroy,
          :picture
        ],
        sessions_attributes: [
          :id,
          :_destroy,
          :created_at,
          :last_seen_at,
          :ip,
          :device,
          :version
        ],
        bans_attributes: [
          :id,
          :_destroy,
          :notification_message,
          :ban_reason,
          :banned_until
        ]
      ])
    end
  end

  [ 1.week, 1.month, 1.year ].each do |duration|
    label = duration.parts.to_a[0].reverse.join(' ')

    action_item "ban_for_#{label}", only: %i[show edit] do
      link_to("Ban for #{label}".humanize,
        new_admin_ban_path({
          user_id: user.id,
          user_name: user.name,
          telegram_id: user.telegram_id,
          banned_until: duration.from_now.iso8601,
        })
      )
    end
  end

  action_item "ban_permanently", only: %i[show edit] do
    link_to("Ban permanently",
      new_admin_ban_path({
        user_id: user.id,
        user_name: user.name,
        telegram_id: user.telegram_id,
      })
    )
  end

  index do
    selectable_column
    column :name do |record|
      link_to record.name.truncate(32), edit_admin_user_path(record)
    end
    column :telegram_username do |record|
      if record.telegram_username.present?
        link_to "@#{record.telegram_username}", "https://t.me/#{record.telegram_username}"
      else
        "N/A"
      end
    end
    column :karma do |record|
      span record.karma.floor(1), style: record.karma_ok? ? "color: green" : "color: red"
    end
    column :banned do |record|
      record.state == "banned"
    end
    column :created_at
    actions
  end

  filter :name, as: :string 
  filter :telegram_username
  filter :telegram_id_eq
  filter :bio 
  filter :like
  filter :dislike
  filter :age_cache, label: "Age"
  filter :state, as: :select, collection: [:visible, :hidden, :banned]
  filter :karma
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      if f.object.state == "banned"
        f.input :state, as: :select, collection: [:banned], input_html: { disabled: true }, hint: "Remove all ongoing bans to unban"
      else
        f.input :state, as: :select, collection: [:visible, :hidden]
      end

      f.input :avatar, as: :file, hint: (f.object.avatar_url.present? ? image_tag(f.object.avatar.url(:large)) : nil)

      f.input :karma_base, input_html: { value: f.object.karma - f.object.karma_boost, disabled: true }
      Karma.rules_for(f.object).each do |rule, value|
        f.input "karma_rule_#{rule}", input_html: { value: value, disabled: true }
      end


      f.input :karma_boost
      f.input :karma, input_html: { disabled: true }

      f.input :telegram_username
      f.input :telegram_id
      f.input :bio, input_html: { rows: 3 }
      f.input :like, input_html: { rows: 3 }
      f.input :dislike, input_html: { rows: 3 }

      f.input :hide_likes

      f.input :birthdate
      f.input :age_cache, label: "Age", input_html: { disabled: true }

      f.input :latitude, input_html: { value: f.object.lonlat&.latitude }
      f.input :longitude, input_html: { value: f.object.lonlat&.longitude }
      f.input :localities, input_html: { disabled: true }
      f.input :maximum_searchable_distance
      f.input :location_changed_at
      f.input :hide_city

      f.input :allow_chat_notification
      f.input :allow_message_notification
      f.input :allow_like_notification
      f.input :allow_event_created_notification
      f.input :allow_event_joined_notification

      br
      br
      br

      ProfileFieldGroup.all.sort_by(&:label).each do |profile_field_group|
        panel profile_field_group.label

        profile_field_group.profile_fields.find_each do |profile_field|
          input :profile_field_values, label: profile_field.label, as: :string, input_html: { value: f.object.profile_field_values[profile_field.name], name: "user[profile_field_values][#{profile_field.name}]" }
        end
      end

      br
      br
      br

      f.has_many :pictures, allow_destroy: true do |fp|
        fp.input :picture, as: :file, hint: (fp.object.picture_url.present? ? image_tag(fp.object.picture.url(:full), style: "height: 200px") : nil)
      end


      br
      br
      br

      f.has_many :sessions, allow_destroy: true do |fs|
        fs.input :uuid, as: :string, input_html: { disabled: true }
        fs.input :created_at
        fs.input :last_seen_at
        fs.input :ip
        fs.input :device
        fs.input :version
      end

      br
      br
      br

      f.has_many :bans, allow_destroy: true do |fb|
        fb.input :notification_message, label: "Reason shown to the user"
        fb.input :ban_reason, label: "Ban details (private)"
        fb.input :banned_until
      end
    end
    f.actions
  end
end

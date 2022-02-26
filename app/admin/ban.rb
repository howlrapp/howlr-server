ActiveAdmin.register Ban do
  sort_order = 'created_at_desc'

  permit_params :ban_reason, :banned_until, :name, :telegram_id, :user_id

  index do
    selectable_column
    column :name do |record|
      if record.user.present?
        link_to record.user.name.truncate(32), edit_admin_user_path(record.user)
      else
        "#{record["user_attributes"]["name"]} (deleted)"
      end
    end
    column :ban_reason
    column :banned_until do |record|
      if record.banned_until.present?
        record.banned_until
      else
        "Permanently"
      end
    end
    actions
  end

  filter :name, as: :string
  filter :ban_reason, as: :string
  filter :user_id, as: :string, label: "User ID"

  form do |f|
    f.object.banned_until ||= params[:banned_until]
    f.object.user_id ||= params[:user_id]
    f.object.telegram_id ||= params[:telegram_id]

    f.inputs "Ban Details" do
      f.input :user_id, as: :string
      f.input :telegram_id, as: :string
      f.input :name, as: :string, input_html: { disabled: true, value: f.object&.name || params[:user_name] } 

      f.input :notification_message, label: "Reason shown to the user"
      f.input :ban_reason, label: "Ban details (private)"
      f.input :banned_until, value: params[:banned_until]
    end
    f.actions
  end
end

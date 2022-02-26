ActiveAdmin.register Report do
  actions :index, :show, :update, :destroy

  config.sort_order = 'created_at_desc'

  permit_params :status

  [ 1.week, 1.month, 1.year ].each do |duration|
    label = duration.parts.to_a[0].reverse.join(' ')

    action_item "ban_for_#{label}", only: %i[show edit] do
      link_to("Ban user for #{label}".humanize,
        new_admin_ban_path({
          user_id: report.subject_id,
          user_name: report.subject&.name,
          telegram_id: report.subject&.telegram_id,
          banned_until: duration.from_now.iso8601,
        })
      )
    end
  end

  action_item "ban_permanently", only: %i[show edit] do
    link_to("Ban user permanently",
      new_admin_ban_path({
        user_id: report.subject_id,
        user_name: report.subject&.name,
        telegram_id: report.subject&.telegram_id
      })
    )
  end

  action_item('close', only: %i[show]) do
    if report.status != 'closed'
      button_to(
        "Close report",
        admin_report_path(report),
        method: :put,
        params: { report: { status: 'closed' } },
        form_class: "action-button action-good"
      )
    end
  end

  action_item('reoppen', only: %i[show]) do
    if report.status != 'new'
      button_to(
        "Re-open report",
        admin_report_path(report),
        method: :put,
        params: { report: { status: 'new' } },
        form_class: "action-button action-bad"
      )
    end
  end

  index do
    selectable_column
    column :status do |record|
      span record.status, style: record.status == 'closed' ? "color: green" : "color: red"
    end
    column :subject_type
    column :subject do |record|
      case record.subject_type
      when "User"
        if record.subject.present?
          link_to record.subject.name, edit_admin_user_path(record.subject)
        else
          "User deleted"
        end
      when "Event"
        if record.subject.present?
          link_to record.subject.title, admin_event_path(record.subject)
        else
          "Event deleted"
        end
      end
    end
    column :reporter do |record|
      if record.reporter.present?
        link_to record.reporter.name, edit_admin_user_path(record.reporter)
      else
        "User deleted"
      end
    end

    column :description do |record|
      record.description.truncate(40)
    end
    column :created_at

    actions
  end

  filter :status, as: :select, collection: [:new, :closed]
  filter :reporter_name, as: :string
  filter :description
  filter :created_at
  filter :subject_of_User_type_name_contains
  filter :subject_of_Event_type_title_contains

  form do |f|
    f.inputs "Report Details" do
      f.input :status, as: :select, collection: [:new, :closed]
      f.input :description, input_html: { disabled: true }
    end
    f.actions
  end
end

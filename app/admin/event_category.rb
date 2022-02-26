ActiveAdmin.register EventCategory do
  menu parent: "Configuration"

  permit_params :label, :system

  config.sort_order = 'label_asc'

  index do
    selectable_column
    column :label do |record|
      link_to record.label, admin_event_category_path(record)
    end
    column :events do |record|
      link_to record.events.count, admin_events_path("q[event_category_uuid_eq]" => record.id)
    end
    column :created_at
    actions
  end

  filter :label

  form do |f|
    f.inputs "Event Category Details" do
      f.input :label
      f.input :system, label: "Reserved to system (not selectable by users)"
    end
    f.actions
  end
end

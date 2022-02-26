ActiveAdmin.register MatchKind do
  menu parent: "Configuration"

  permit_params :name, :order, :label

  config.sort_order = 'order_asc'

  index do
    selectable_column
    column :label do |record|
      link_to record.label, admin_match_kind_path(record)
    end
    column :name
    column :order
    column :created_at
    actions
  end

  filter :name
  filter :label

  form do |f|
    f.inputs "MatchKind Details" do
      f.input :name
      f.input :label
      f.input :order
    end
    f.actions
  end
end

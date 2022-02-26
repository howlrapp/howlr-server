ActiveAdmin.register GroupCategory do
  menu parent: "Configuration"

  permit_params :order, :label

  config.sort_order = 'order_asc'

  index do
    selectable_column
    column :label do |record|
      link_to record.label, admin_group_category_path(record)
    end
    column :groups do |record|
      link_to record.groups.count, admin_groups_path("q[group_category_uuid_eq]" => record.id)
    end
    column :order
    column :created_at
    actions
  end

  filter :label

  form do |f|
    f.inputs "Group Category Details" do
      f.input :label
      f.input :order
    end
    f.actions
  end
end

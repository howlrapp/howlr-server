ActiveAdmin.register Group do
  permit_params :name, :group_category_id

  index do
    selectable_column
    column :name do |record|
      link_to record.name, admin_group_path(record)
    end
    column :category do |record|
      record.group_category&.label
    end
    column :created_at
    actions
  end

  filter :name
  filter :group_category
  filter :created_at

  form do |f|
    f.inputs "Associations" do
      f.input :group_category
    end
    f.inputs "Group Details" do
      f.input :name
    end
    f.actions
  end
end

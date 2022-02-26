ActiveAdmin.register ProfileFieldGroup do
  menu parent: "Configuration"

  config.sort_order = 'order_asc'

  permit_params :label, :order, profile_fields_attributes: [
    :id,
    :_destroy,
    :name,
    :label,
    :regexp,
    :pattern,
    :validation,
    :deep_link_pattern,
    :app_store_id,
    :play_store_id,
    :description,
    :restricted
  ]

  index do
    selectable_column
    column :label do |record|
      link_to record.label, admin_profile_field_group_path(record)
    end
    column :profile_fields do |record|
      record.profile_fields.map(&:label).join(", ")
    end
    column :order
    column :created_at
    actions
  end

  filter :label

  form do |f|
    f.inputs "Profile field group Details" do
      f.input :label
      f.input :order
      f.has_many :profile_fields, allow_destroy: true do |ff|
        ff.input :id, as: "hidden"

        ff.input :name
        ff.input :label
        ff.input :description

        ff.input :pattern
        ff.input :regexp
        ff.input :deep_link_pattern
        ff.input :validation

        ff.input :app_store_id
        ff.input :play_store_id

        ff.input :restricted
      end


    end
    f.actions
  end
end

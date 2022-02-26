ActiveAdmin.register Event do
  permit_params :title, :description, :date, :maximum_searchable_distance, :user_id, :latitude, :longitude, :event_category_id

  config.sort_order = 'created_at_desc'

  index do
    selectable_column
    column :category do |record|
      record.event_category.label
    end
    column :title do |record|
      link_to record.title.truncate(32), admin_event_path(record)
    end
    column :user do |record|
      link_to record.user.name, edit_admin_user_path(record.user)
    end
    column :open do |record|
      record.privacy_status == 'open'
    end
    column :date
    column :created_at
    actions
  end

  filter :title
  filter :user_name_contains
  filter :privacy_status, as: :select, collection: [:open, :liked_only]
  filter :event_category
  filter :created_at
  filter :date

  form do |f|
    f.inputs "Associations" do
      f.input :event_category
    end

    f.inputs "Event Details" do
      f.input :title
      f.input :description
      f.input :date
      f.input :latitude
      f.input :longitude
      f.input :maximum_searchable_distance
      f.input :user_id, as: :string
    end
    f.actions
  end
end

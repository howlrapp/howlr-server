ActiveAdmin.register Changelog do
  menu parent: "Content"

  permit_params :id, :body

  config.sort_order = 'created_at_desc'

  index do
    selectable_column
    column :body do |record|
      record.body.truncate(64)
    end
    column :created_at
    actions
  end

  filter :body

  form do |f|
    f.inputs "Changelog Details" do
      f.input :body
    end
    f.actions
  end
end

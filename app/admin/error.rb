ActiveAdmin.register Error do
  sort_order = 'created_at_desc'
  actions :index, :show, :destroy

  filter :exception
  filter :created_at

  index do
    selectable_column
    column :exception do |record|
      record.exception.truncate(64)
    end
    column :created_at
    actions
  end
end

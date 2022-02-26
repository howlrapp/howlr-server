[ FaqItem, TosItem, PrivacyPolicyItem ].each do |model|
  ActiveAdmin.register model do
    menu parent: "Content"

    permit_params :id, :title, :body, :order

    config.sort_order = 'order_asc'

    filter :title
    filter :body

    index do
      selectable_column
      column :title
      column :body do |record|
        record.body.truncate(64)
      end
      column :order
      column :created_at
      actions
    end

    form do |f|
      f.inputs "#{model} Details" do
        f.input :title
        f.input :body
        f.input :order
      end
      f.actions
    end

  end
end

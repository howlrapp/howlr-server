Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  telegram_webhook TelegramCodeController

  root to: proc { [404, {}, ["Not found"]] }
end

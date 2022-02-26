class Users::RemoveIdleJob < ApplicationJob
  queue_as :default

  def perform
    App.find_each do |app|
      idle_users(app).find_each { |user| remove(user) }
    end
  end

  protected

  def remove(user)
    user.destroy
  end

  def idle_users(app)
    User.where.not(last_seen_at: nil).where("last_seen_at < ?", app.account_removal_months_count.month.ago)
  end
end

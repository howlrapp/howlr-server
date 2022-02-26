class Ban < ApplicationRecord
  belongs_to :user, optional: true

  before_create :store_telegram_id
  before_create :store_user_attributes

  after_create :set_banned_state_to_user
  after_create :destroy_user_sessions!

  # :nocov:
  ransacker :name do |scope|
    Arel.sql("bans.user_attributes ->> 'name'")
  end

  def name
    user_attributes["name"]
  end
  # :nocov:

  def self.find_last_active_ban_for(telegram_id)
    Ban
      .order(created_at: :desc)
      .where(telegram_id: telegram_id)
      .where("bans.banned_until IS NULL OR bans.banned_until > ?", DateTime.now)
      .first
  end

  def ban_end_in_words
    if banned_until.present?
      "until #{self.banned_until.strftime("%B %d, %Y at %H:%M UTC")}"
    else
      "permanently"
    end
  end

  def ban_in_words
    if self.notification_message.present?
      "You have been banned #{self.ban_end_in_words} for the following reason: #{self.notification_message}."
    else
      "You have been banned #{self.ban_end_in_words}."
    end
  end

  def store_telegram_id
    self.telegram_id = user.telegram_id
  end

  def store_user_attributes
    self.user_attributes = self.user.attributes.slice(
      "name",
      "telegram_username",
      "uuid",
      "like",
      "dislike",
      "bio",
      "birthdate"
    )
  end

  def set_banned_state_to_user
    self.user.update(state: "banned") if self.user.present?
  end

  def destroy_user_sessions!
    self.user.sessions.destroy_all
  end
end

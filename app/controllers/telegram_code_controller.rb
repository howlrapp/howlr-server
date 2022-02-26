class TelegramCodeController < Telegram::Bot::UpdatesController
  def start!(data = nil, *)
    if ban = Ban.find_last_active_ban_for(self.payload["from"]["id"])
      respond_with :message, text: ban.ban_in_words
      return
    end

    user = User.find_or_create_by!(telegram_id: self.payload["from"]["id"]) do |user|
      user.name = self.payload["from"]["first_name"]
      user.telegram_username = self.payload["from"]["username"]
      user.last_seen_at = DateTime.now
      save_profile_photo!(user)
    end

    session = ::Session.create!(user: user)
    user.update(state: "visible")

    respond_with :message, text: "Please use the following code to sign up:\n\n<b>#{session.code}</b>", parse_mode: "HTML"
  rescue Telegram::Bot::Forbidden
    # Ignore, it happens when people block the bot
  rescue => error
    ExceptionNotifier.notify_exception(error)

    respond_with :message, text: "An unexpected error has occurred. Please try again later."
  end

  def save_profile_photo!(user)
    profile_photos = self.bot.get_user_profile_photos(user_id: user.telegram_id, limit: 1)
    return if profile_photos["result"]["total_count"] == 0

    profile_photo_file = profile_photos["result"]["photos"][0].sort_by do |profile_photo|
      profile_photo["width"]
    end.last
    if profile_photo_file.present?
      profile_photo_file_path = self.bot.get_file(file_id: profile_photo_file['file_id'])["result"]["file_path"]
      user.remote_avatar_url = "https://api.telegram.org/file/bot#{self.bot.token}/#{profile_photo_file_path}"
    end

  rescue => error
    ExceptionNotifier.notify_exception(error)
  end
end

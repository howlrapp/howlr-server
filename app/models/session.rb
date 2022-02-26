class Session < ApplicationRecord
  CODE_CHARACTER_SET = ('A'..'Z').to_a - ['O', 'I'] + ('1'..'9').to_a

  self.primary_key = :uuid

  belongs_to :user

  before_create :set_code

  after_commit :update_user_state

  def self.generate_code
    code = nil

    loop do
      code = (0...Rails.configuration.code_length).map { CODE_CHARACTER_SET[SecureRandom.random_number(CODE_CHARACTER_SET.size)] }.join

      # Just make sure we never use the code we use for Apple reviewers
      break if code != Rails.configuration.apple_sign_up_code
    end

    code
  end

  def set_code
    self.code = Session.generate_code
    self.code_expiration_date = Rails.configuration.code_expiration_delay.seconds.from_now
  end

  protected

  def update_user_state
    if user.state != "banned" && !user.frozen?
      user.update(state: user.sessions.count > 0 ? "visible" : "hidden")
    end
  end
end

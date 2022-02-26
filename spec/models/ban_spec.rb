require 'rails_helper'

RSpec.describe Ban, type: :model do
  let(:ban) { create(:ban, banned_until: 1.year.from_now) }
  let(:ban_with_message) { create(:ban, notification_message: "__blah__") }
  let(:permanent_ban) { create(:ban) }

  describe "ban_in_words" do
    it "workds" do
      expect(ban.ban_in_words).to match(1.year.from_now.year.to_s)
      expect(ban_with_message.ban_in_words).to match("__blah__")
      expect(permanent_ban.ban_in_words).to match("permanently")
    end
  end

end

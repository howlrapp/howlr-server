FactoryBot.define do

  factory :chat do
    association :sender, factory: :user
    association :recipient, factory: :user

    is_sender_unread { [true, false].sample }
    is_recipient_unread { [true, false].sample }

    transient do
      messages_count { 2 }
    end

    after(:create) do |chat, evaluator|
      evaluator.messages_count.times do
        create(:message, chat: chat, sender: [chat.sender, chat.recipient].sample)
      end

      chat.reload
    end
  end

end

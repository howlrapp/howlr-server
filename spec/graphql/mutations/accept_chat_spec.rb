require 'rails_helper'

RSpec.describe 'Mutations::AcceptChat' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }
  let(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind, accepted_at: nil }
  let(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind, accepted_at: nil }
  let(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind, accepted_at: nil }

  ACCEPT_CHAT = %{
    mutation acceptChat($input: AcceptChatInput!) {
      acceptChat(input: $input) {
        chat {
          id
          unread
          recipientId
          senderId
          matchKindId
          acceptedAt
          updatedAt
          previewMessage {
            id
            body
            pictureUrl
            senderId
          }
          contact {
            id
            name
            avatarUrl
            system
            online
          }
        }
      }
    }
  }

  context "valid_params" do
    it "accept a chat create by other" do
      FactoryBot.create :message, chat: chat_from_other, sender: user_that_likes_me

      ActiveJob::Base.queue_adapter = :test
      expect {
        expect(chat_from_other.is_recipient_unread).to eq(true)
        result = HowlrSchema.execute(ACCEPT_CHAT,
          context: { current_user: user },
          variables: {
            input: {
              chatId: chat_from_other.id,
            }
          }
        )
        expect(result["data"]["acceptChat"]["chat"]["id"]).to_not eq(nil)
        expect(result["data"]["acceptChat"]["chat"]["acceptedAt"]).to_not eq(nil)
        expect(result["data"]["acceptChat"]["chat"]["contact"]["id"]).to eq(user_that_likes_me.id)
      }.to have_enqueued_job.twice
    end

    it "can block" do
      user.update(blocked_users_ids: [user_that_likes_me.id])
      result = HowlrSchema.execute(ACCEPT_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_that_likes_me.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ACCEPT_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "accept a chat create by other" do
      FactoryBot.create :message, chat: chat_from_other, sender: user_that_likes_me
      Ban.create(user: user)

      result = HowlrSchema.execute(ACCEPT_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to accept chat if not connected" do
      result = HowlrSchema.execute(ACCEPT_CHAT,
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to accept chats I creadet" do
      result = HowlrSchema.execute(ACCEPT_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: other_chat.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to accept other chats" do
      result = HowlrSchema.execute(ACCEPT_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: other_chat.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

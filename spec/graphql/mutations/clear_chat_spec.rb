require 'rails_helper'

RSpec.describe 'Mutations::ReadChat' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }
  let(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind }
  let(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind }
  let(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind }

  CLEAR_CHAT = %{
    mutation clearChat($input: ClearChatInput!) {
      clearChat(input: $input) {
        chat {
          id
          unread
          recipientId
          senderId
          matchKindId
          acceptedAt
          updatedAt
          messages {
            id
          }
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
    it "clear a chat created by me" do
      FactoryBot.create :message, chat: chat_from_me, sender: user

      expect(chat_from_me.messages.count).to_not eq(0)
      result = HowlrSchema.execute(CLEAR_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["data"]["clearChat"]["chat"]["id"]).to eq(chat_from_me.id)
      expect(result["data"]["clearChat"]["chat"]["messages"].count).to eq(0)
    end

    it "clear a chat create by other" do
      FactoryBot.create :message, chat: chat_from_other, sender: user_that_likes_me

      expect(chat_from_other.messages.count).to_not eq(0)
      result = HowlrSchema.execute(CLEAR_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["data"]["clearChat"]["chat"]["id"]).to eq(chat_from_other.id)
      expect(result["data"]["clearChat"]["chat"]["messages"].count).to eq(0)
    end

    it "can block but still clear" do
      user.update(blocked_users_ids: [user_i_like.id])
      expect(chat_from_me.messages.count).to_not eq(0)
      result = HowlrSchema.execute(CLEAR_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["data"]["clearChat"]["chat"]["id"]).to eq(chat_from_me.id)
      expect(result["data"]["clearChat"]["chat"]["messages"].count).to eq(0)
    end

    it "can get blocked but still clear" do
      user_i_like.update(blocked_users_ids: [user.id])
      expect(chat_from_me.messages.count).to_not eq(0)
      result = HowlrSchema.execute(CLEAR_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["data"]["clearChat"]["chat"]["id"]).to eq(chat_from_me.id)
      expect(result["data"]["clearChat"]["chat"]["messages"].count).to eq(0)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(CLEAR_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )

      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to clear chat if not connected" do
      result = HowlrSchema.execute(CLEAR_CHAT,
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to clear other chats" do
      result = HowlrSchema.execute(CLEAR_CHAT,
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

require 'rails_helper'

RSpec.describe 'Mutations::ReadChat' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }
  let(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind }
  let(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind }
  let(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind }

  READ_CHAT = %{
    mutation readChat($input: ReadChatInput!) {
      readChat(input: $input) {
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
    it "read a chat created by me" do
      FactoryBot.create :message, chat: chat_from_me, sender: user

      chat_from_me.update(is_sender_unread: true)
      result = HowlrSchema.execute(READ_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["data"]["readChat"]["chat"]["id"]).to_not eq(nil)
      expect(result["data"]["readChat"]["chat"]["unread"]).to eq(false)
      expect(result["data"]["readChat"]["chat"]["contact"]["id"]).to eq(user_i_like.id)
    end

    it "read a chat create by other" do
      FactoryBot.create :message, chat: chat_from_other, sender: user_that_likes_me

      chat_from_other.update(is_recipient_unread: true)
      result = HowlrSchema.execute(READ_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["data"]["readChat"]["chat"]["id"]).to_not eq(nil)
      expect(result["data"]["readChat"]["chat"]["unread"]).to eq(false)
      expect(result["data"]["readChat"]["chat"]["contact"]["id"]).to eq(user_that_likes_me.id)
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(READ_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(READ_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      Ban.create(user: user)

      result = HowlrSchema.execute(READ_CHAT,
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
    it "is not authorized to read chat if not connected" do
      result = HowlrSchema.execute(READ_CHAT,
        variables: {
          input: {
            chatId: chat_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to read other chats" do
      result = HowlrSchema.execute(READ_CHAT,
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

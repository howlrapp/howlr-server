require 'rails_helper'

RSpec.describe 'Mutations::RemoveMessage' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }

  let(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind, messages_count: 1 }
  let!(:message_from_me) { FactoryBot.create :message, chat: chat_from_me, body: "test", sender: user }

  let(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind, messages_count: 1 }
  let!(:message_from_other) { FactoryBot.create :message, chat: chat_from_other, body: "test", sender: user_that_likes_me }

  let(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind, messages_count: 1 }
  let!(:other_message) { FactoryBot.create :message, chat: other_chat, sender: user_that_likes_me, body: "test" }

  REMOVE_MESSAGE = %{
    mutation removeMessage($input: RemoveMessageInput!) {
      removeMessage(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "delete a message I sent" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect(chat_from_me.messages.count).to eq(2)
        result = HowlrSchema.execute(REMOVE_MESSAGE,
          context: { current_user: user },
          variables: {
            input: {
              messageId: message_from_me.id,
            }
          }
        )
        expect(result["data"]["removeMessage"]["id"]).to eq(message_from_me.id)
        expect(chat_from_me.messages.count).to eq(1)
      }.to have_enqueued_job.exactly(2).times
    end

    it "Delete other user message" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect(chat_from_other.messages.count).to eq(2)
        result = HowlrSchema.execute(REMOVE_MESSAGE,
          context: { current_user: user },
          variables: {
            input: {
              messageId: message_from_other.id,
            }
          }
        )
        expect(result["data"]["removeMessage"]["id"]).to eq(message_from_other.id)
        expect(chat_from_other.messages.count).to eq(1)
      }.to have_enqueued_job.exactly(2).times
    end

    it "can block but still delete" do
      user.update(blocked_users_ids: [user_i_like.id])
      expect(chat_from_me.messages.count).to eq(2)
      result = HowlrSchema.execute(REMOVE_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            messageId: message_from_me.id,
          }
        }
      )
      expect(result["data"]["removeMessage"]["id"]).to eq(message_from_me.id)
      expect(chat_from_me.messages.count).to eq(1)
    end

    it "can get blocked but still delete" do
      user_i_like.update(blocked_users_ids: [user.id])
      expect(chat_from_me.messages.count).to eq(2)
      result = HowlrSchema.execute(REMOVE_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            messageId: message_from_me.id,
          }
        }
      )
      expect(result["data"]["removeMessage"]["id"]).to eq(message_from_me.id)
      expect(chat_from_me.messages.count).to eq(1)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            messageId: message_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to delete message chat if not connected" do
      result = HowlrSchema.execute(REMOVE_MESSAGE,
        variables: {
          input: {
            messageId: message_from_me.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to delete message in other chats" do
      result = HowlrSchema.execute(REMOVE_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            messageId: other_message.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to delete unknown messages" do
      result = HowlrSchema.execute(REMOVE_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            messageId: "unknown",
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end
  end
end

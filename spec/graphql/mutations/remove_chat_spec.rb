require 'rails_helper'

RSpec.describe 'Mutations::RemoveChat' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }
  let!(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind }
  let!(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind }
  let!(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind }

  REMOVE_CHAT = %{
    mutation removeChat($input: RemoveChatInput!) {
      removeChat(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "remove a chat create by other" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect {
          result = HowlrSchema.execute(REMOVE_CHAT,
            context: { current_user: user },
            variables: {
              input: {
                chatId: chat_from_other.id,
              }
            }
          )
          expect(result["data"]["removeChat"]["id"]).to_not eq(nil)
        }.to change(Chat, :count).by(-1)
      }.to have_enqueued_job
    end

    it "remove a chat created by me" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect {
          result = HowlrSchema.execute(REMOVE_CHAT,
            context: { current_user: user },
            variables: {
              input: {
                chatId: chat_from_me.id,
              }
            }
          )
          expect(result["data"]["removeChat"]["id"]).to_not eq(nil)
        }.to change(Chat, :count).by(-1)
      }.to have_enqueued_job
    end

    it "can block but can still delete" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect {
          result = HowlrSchema.execute(REMOVE_CHAT,
            context: { current_user: user },
            variables: {
              input: {
                chatId: chat_from_other.id,
              }
            }
          )
          expect(result["data"]["removeChat"]["id"]).to_not eq(nil)
        }.to change(Chat, :count).by(-1)
      }.to have_enqueued_job
    end

    it "can get blocked but can still delete" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect {
          result = HowlrSchema.execute(REMOVE_CHAT,
            context: { current_user: user },
            variables: {
              input: {
                chatId: chat_from_me.id,
              }
            }
          )
          expect(result["data"]["removeChat"]["id"]).to_not eq(nil)
        }.to change(Chat, :count).by(-1)
      }.to have_enqueued_job
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_CHAT,
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
    it "is not authorized to delete chat if not connected" do
      result = HowlrSchema.execute(REMOVE_CHAT,
        variables: {
          input: {
            chatId: chat_from_other.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to delete chats I creadet" do
      result = HowlrSchema.execute(REMOVE_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            chatId: other_chat.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to delete other chats" do
      result = HowlrSchema.execute(REMOVE_CHAT,
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

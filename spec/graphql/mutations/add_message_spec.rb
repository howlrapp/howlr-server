require 'rails_helper'

RSpec.describe 'Mutations::AddMessage' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }
  let(:chat_from_me) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind, accepted_at: DateTime.now }
  let(:chat_from_other) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind, accepted_at: DateTime.now }
  let(:other_chat) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user_i_like, match_kind: match_kind, accepted_at: DateTime.now }

  let(:base64_picture) {
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII="
  }

  ADD_MESSAGE = %{
    mutation addMessage($input: AddMessageInput!) {
      addMessage(input: $input) {
        message {
          id
          body
          senderId
          createdAt
          thumbnailUrl
          pictureUrl
        }
      }
    }
  }

  context "valid_params" do
    it "add a message in a chat created by me" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        chat_from_me.update(is_recipient_unread: true)
        result = HowlrSchema.execute(ADD_MESSAGE,
          context: { current_user: user },
          variables: {
            input: {
              chatId: chat_from_me.id,
              body:  "coucou"
            }
          }
        )
        expect(result["data"]["addMessage"]["message"]["id"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["createdAt"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["body"]).to eq("coucou")
        expect(chat_from_me.reload.is_recipient_unread).to eq(true)
      }.to have_enqueued_job.exactly(3).times
    end

    it "add a picture message in a chat created by me" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        chat_from_me.update(is_recipient_unread: true)
        result = HowlrSchema.execute(ADD_MESSAGE,
          context: { current_user: user },
          variables: {
            input: {
              chatId: chat_from_me.id,
              pictureUrl: base64_picture
            }
          }
        )
        expect(result["data"]["addMessage"]["message"]["id"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["createdAt"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["pictureUrl"]).to match(/jpg$/)
        expect(chat_from_me.reload.is_recipient_unread).to eq(true)
      }.to have_enqueued_job.exactly(3).times
    end

    it "add a message in a chat create by other" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        chat_from_other.update(is_sender_unread: true)
        result = HowlrSchema.execute(ADD_MESSAGE,
          context: { current_user: user },
          variables: {
            input: {
              chatId: chat_from_other.id,
              body: "coucou"
            }
          }
        )
        expect(result["data"]["addMessage"]["message"]["id"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["createdAt"]).to_not eq(nil)
        expect(result["data"]["addMessage"]["message"]["body"]).to eq("coucou")
        expect(chat_from_other.reload.is_sender_unread).to eq(true)
      }.to have_enqueued_job.exactly(3).times
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(ADD_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
            body: "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
            body: "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(ADD_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            chatId: chat_from_me.id,
            body:  "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to add message chat if not connected" do
      result = HowlrSchema.execute(ADD_MESSAGE,
        variables: {
          input: {
            chatId: chat_from_me.id,
            body: "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to message other chats" do
      result = HowlrSchema.execute(ADD_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            chatId: other_chat.id,
            body: "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "is not authorized to post on unknown chats" do
      result = HowlrSchema.execute(ADD_MESSAGE,
        context: { current_user: user },
        variables: {
          input: {
            chatId: "unknown",
            body: "coucou"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

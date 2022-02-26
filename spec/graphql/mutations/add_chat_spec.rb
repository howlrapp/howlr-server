require 'rails_helper'

RSpec.describe 'Mutations::AddChat' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:match_kind) { FactoryBot.create :match_kind }

  ADD_CHAT = %{
    mutation addChat($input: AddChatInput!) {
      addChat(input: $input) {
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
    it "adds a chat" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        result = HowlrSchema.execute(ADD_CHAT,
          context: { current_user: user },
          variables: {
            input: {
              recipientId: user_i_like.id,
              matchKindId: match_kind.id,
            }
          }
        )
        expect(result["data"]["addChat"]["chat"]["id"]).to_not eq(nil)
        expect(result["data"]["addChat"]["chat"]["contact"]["id"]).to eq(user_i_like.id)
      }.to have_enqueued_job.twice
    end

    it "use existing chat if it exists" do
      ActiveJob::Base.queue_adapter = :test

      chat_already_created = Chat.create!(
        recipient: user,
        sender: user_i_like,
        match_kind: match_kind
      )

      expect {
        result = HowlrSchema.execute(ADD_CHAT,
          context: { current_user: user },
          variables: {
            input: {
              recipientId: user_i_like.id,
              matchKindId: match_kind.id,
            }
          }
        )
        expect(result["data"]["addChat"]["chat"]["id"]).to eq(chat_already_created.id)
        expect(result["data"]["addChat"]["chat"]["contact"]["id"]).to eq(user_i_like.id)
      }.to_not have_enqueued_job
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(ADD_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            recipientId: user_i_like.id,
            matchKindId: match_kind.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            recipientId: user_i_like.id,
            matchKindId: match_kind.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(ADD_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            recipientId: user_i_like.id,
            matchKindId: match_kind.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to chat if not connected" do
      result = HowlrSchema.execute(ADD_CHAT,
        variables: {
          input: {
            recipientId: user_i_like.id,
            matchKindId: match_kind.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot chat without recipient" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            recipientId: "nobody",
            matchKindId: match_kind.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot chat without matchKind" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_CHAT,
        context: { current_user: user },
        variables: {
          input: {
            recipientId: user_i_like.id,
            matchKindId: "nothing",
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

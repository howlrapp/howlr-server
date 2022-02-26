require 'rails_helper'

RSpec.describe 'Queries::ChatQUery' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }

  let(:match_kind) { FactoryBot.create :match_kind }

  let!(:chat1) { FactoryBot.create :chat, sender: user, recipient: user_i_like, match_kind: match_kind }
  let!(:chat2) { FactoryBot.create :chat, sender: user_that_likes_me, recipient: user, match_kind: match_kind }

  GET_CHAT = %{
    query getChat($id: ID!) {
      viewer {
        id
        chat(id: $id) {
          id
          unread
          recipientId
          senderId
          matchKindId
          acceptedAt
          updatedAt
          createdAt
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
          messages {
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
  }

  context "valid_params" do
    it "can get chat as sender" do
      result = HowlrSchema.execute(GET_CHAT,
        context: { current_user: user },
        variables: { id: chat1.id }
      )
      expect(result["data"]["viewer"]["chat"]["id"]).to eq(chat1.id)
      expect(result["data"]["viewer"]["chat"]["contact"]["id"]).to eq(user_i_like.id)
      expect(result["data"]["viewer"]["chat"]["messages"].count).to_not eq(0)
      expect(result["data"]["viewer"]["chat"]["previewMessage"]).to_not eq(nil)
    end

    it "can get chat as recipient" do
      result = HowlrSchema.execute(GET_CHAT,
        context: { current_user: user },
        variables: { id: chat2.id }
      )
      expect(result["data"]["viewer"]["chat"]["id"]).to eq(chat2.id)
      expect(result["data"]["viewer"]["chat"]["contact"]["id"]).to eq(user_that_likes_me.id)
      expect(result["data"]["viewer"]["chat"]["messages"].count).to_not eq(0)
      expect(result["data"]["viewer"]["chat"]["previewMessage"]).to_not eq(nil)
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(GET_CHAT,
        context: { current_user: user },
        variables: { id: chat1.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(GET_CHAT,
        context: { current_user: user },
        variables: { id: chat1.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_CHAT,
        context: { current_user: user },
        variables: { id: chat1.id }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

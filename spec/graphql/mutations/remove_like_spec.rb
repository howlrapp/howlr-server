require 'rails_helper'

RSpec.describe 'Mutations::RemoveLike' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }
  let(:user_that_likes_me) { FactoryBot.create :user }
  let!(:like_them) { FactoryBot.create :like, liker: user, liked: user_i_like }
  let!(:other_like) { FactoryBot.create :like, liker: user_that_likes_me, liked: user }

  REMOVE_LIKE = %{
    mutation removeLike($input: RemoveLikeInput!) {
      removeLike(input: $input) {
        id
      }
    }
  }

  context "valid_params" do
    it "remove a like i sent" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        expect {
          result = HowlrSchema.execute(REMOVE_LIKE,
            context: { current_user: user },
            variables: {
              input: {
                likedId: user_i_like.id,
              }
            }
          )
          expect(result["data"]["removeLike"]["id"]).to eq(like_them.id)
        }.to change(Like, :count).by(-1)
      }.to have_enqueued_job
    end

    it "can block but it doesn't prevent unlike" do
      user.update(blocked_users_ids: [user_i_like.id])
      expect {
        result = HowlrSchema.execute(REMOVE_LIKE,
          context: { current_user: user },
          variables: {
            input: {
              likedId: user_i_like.id,
            }
          }
        )
        expect(result["data"]["removeLike"]["id"]).to eq(like_them.id)
      }.to change(Like, :count).by(-1)
    end

    it "can get blocked but it doesn't prevent unlike" do
      user_i_like.update(blocked_users_ids: [user.id])
      expect {
        result = HowlrSchema.execute(REMOVE_LIKE,
          context: { current_user: user },
          variables: {
            input: {
              likedId: user_i_like.id,
            }
          }
        )
        expect(result["data"]["removeLike"]["id"]).to eq(like_them.id)
      }.to change(Like, :count).by(-1)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(REMOVE_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: user_i_like.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "is not authorized to remove like if not connected" do
      result = HowlrSchema.execute(REMOVE_LIKE,
        variables: {
          input: {
            likedId: user_i_like.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot remove like without likedId" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(REMOVE_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: "unknown"
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end

    it "cannot remove other like" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(REMOVE_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: user_that_likes_me.id
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not found")
    end
  end
end

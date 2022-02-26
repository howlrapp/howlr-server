require 'rails_helper'

RSpec.describe 'Mutations::AddLike' do
  let(:user) { FactoryBot.create :user }
  let(:user_i_like) { FactoryBot.create :user }

  ADD_LIKE = %{
    mutation addLike($input: AddLikeInput!) {
      addLike(input: $input) {
        like {
          id
          createdAt
          user {
            id
            name
            distance
            avatarUrl
            online
          }
        }
      }
    }
  }

  context "valid_params" do
    it "adds a like" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        result = HowlrSchema.execute(ADD_LIKE,
          context: { current_user: user },
          variables: {
            input: {
              likedId: user_i_like.id,
            }
          }
        )
        expect(result["data"]["addLike"]["like"]["id"]).to_not eq(nil)
        expect(result["data"]["addLike"]["like"]["user"]["id"]).to eq(user_i_like.id)
      }.to have_enqueued_job.twice
    end

    it "doesn't crash if like already exists" do
      ActiveJob::Base.queue_adapter = :test
      Like.create!(liker: user, liked: user_i_like)

      expect {
        result = HowlrSchema.execute(ADD_LIKE,
          context: { current_user: user },
          variables: {
            input: {
              likedId: user_i_like.id,
            }
          }
        )
        expect(result["data"]["addLike"]["like"]["id"]).to_not eq(nil)
        expect(result["data"]["addLike"]["like"]["user"]["id"]).to eq(user_i_like.id)
      }.to have_enqueued_job.twice
    end

    it "can block" do
      user.update(blocked_users_ids: [user_i_like.id])
      result = HowlrSchema.execute(ADD_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: user_i_like.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: user_i_like.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "can get blocked" do
      Ban.create(user: user)

      result = HowlrSchema.execute(ADD_LIKE,
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
    it "is not authorized to like if not connected" do
      result = HowlrSchema.execute(ADD_LIKE,
        variables: {
          input: {
            likedId: user_i_like.id,
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end

    it "cannot like without liked" do
      user_i_like.update(blocked_users_ids: [user.id])
      result = HowlrSchema.execute(ADD_LIKE,
        context: { current_user: user },
        variables: {
          input: {
            likedId: "nobody",
          }
        }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end

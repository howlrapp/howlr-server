class Mutations::RemoveLike < Mutations::BaseMutation
  argument :liked_id, ID, required: true

  field :id, ID, null: false

  def resolve(liked_id:)
    like = Like.find_by!(liker: context[:current_user], liked_id: liked_id)

    raise Pundit::NotAuthorizedError unless LikePolicy.new(context[:current_user], like).destroy?

    like.destroy!

    Likes::NotifyDestroyedService.new(recipient: like.liked, like: like).call

    { id: like.id }
  end
end

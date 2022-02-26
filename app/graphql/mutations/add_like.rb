class Mutations::AddLike < Mutations::BaseMutation
  argument :liked_id, ID, required: true

  field :like, Types::LikeType, null: true

  def resolve(liked_id:)
    like = Like.find_or_initialize_by(
      liker: context[:current_user],
      liked_id: liked_id,
    )

    raise Pundit::NotAuthorizedError unless LikePolicy.new(context[:current_user], like).create?

    like.save!

    if context[:current_user].karma_ok?
      Likes::NotifyCreatedService.new(recipient: like.liked, like: like).call
    end

    { like: like }
  end
end

class Mutations::AddPicture < Mutations::BaseMutation
  argument :picture_url, String, required: true

  field :picture, Types::PictureType, null: true

  def resolve(picture_url:)
    picture = Picture.new(
      picture: picture_url,
      user: context[:current_user]
    )

    raise Pundit::NotAuthorizedError unless PicturePolicy.new(context[:current_user], picture).create?

    picture.save!

    { picture: picture.reload }
  end
end

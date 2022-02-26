class Mutations::RemovePicture < Mutations::BaseMutation
  argument :picture_id, ID, required: true

  field :id, ID, null: false

  def resolve(picture_id:)
    picture = Picture.find(picture_id)

    raise Pundit::NotAuthorizedError unless PicturePolicy.new(context[:current_user], picture).destroy?

    picture.destroy!

    { id: picture.id }
  end
end

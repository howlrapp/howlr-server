module Types
  class PictureType < Types::BaseObject
    field :id, ID, null: false
    field :picture_url, String, null: false
    field :thumbnail_url, String, null: false
    field :created_at, String, null: false

	  def picture_url
	    object.picture_url(:full)
	  end

	  def thumbnail_url
	    object.picture_url(:thumbnail)
	  end

    def created_at
      object.created_at&.iso8601
    end
  end
end

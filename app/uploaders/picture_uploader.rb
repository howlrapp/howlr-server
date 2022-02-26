class PictureUploader < DefaultUploader
  def store_dir
    compute_store_dir(namespace: "picture")
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  version :full do
    process resize_to_fit: [Rails.configuration.picture_full_width, Rails.configuration.picture_full_height]
  end

  version :thumbnail do
    process resize_to_fill: [Rails.configuration.picture_thumbnail_size, Rails.configuration.picture_thumbnail_size]
  end
end

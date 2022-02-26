class AvatarUploader < DefaultUploader
  def store_dir
    compute_store_dir(namespace: "avatar")
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  version :tiny do
    process resize_to_fill: [Rails.configuration.avatar_tiny_size, Rails.configuration.avatar_tiny_size]
  end

  version :large do
    process resize_to_fill: [Rails.configuration.avatar_large_size, Rails.configuration.avatar_large_size]
  end
end

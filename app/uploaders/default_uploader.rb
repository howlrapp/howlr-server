class DefaultUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  after :store, :remove_original_file

  def remove_original_file(_p)
    return unless Rails.configuration.remove_original_file

    if self.version_name.nil?
      self.file.delete if self.file.exists?
    end
  end

  def filename
    "#{secure_token}.jpg" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid[0..7])
  end

  def compute_store_dir(namespace:)
    # Compute a secure path for our file, by secure we mean that even if you know
    # anything about the image (like its id or owner id) you won't be able to compute
    # its path without knowing secret_key_base.
    random_dir = Digest::SHA1.hexdigest("#{namespace}#{Rails.configuration.secret_key_base}#{model.id}").insert(3, '/')

    "uploads/#{random_dir}"
  end
end

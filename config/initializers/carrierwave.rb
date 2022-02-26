if Rails.configuration.s3_bucket.present? && !Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.configuration.s3_access_key_id,
      aws_secret_access_key: Rails.configuration.s3_secret_access_key,
      region:                Rails.configuration.s3_region,
      path_style:            true
    }

    if Rails.configuration.s3_endpoint.present?
      config.fog_credentials =
        config.fog_credentials.merge(endpoint: Rails.configuration.s3_endpoint)
    end

    if Rails.configuration.s3_host.present?
      config.fog_credentials =
        config.fog_credentials.merge(s3_host: Rails.configuration.s3_host)
    end

    config.storage = :fog
    config.fog_directory  = Rails.configuration.s3_bucket
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.fog_public = false

    config.asset_host = Rails.configuration.asset_host
  end
else
  CarrierWave.configure do |config|
    config.storage :file

    config.asset_host = Rails.configuration.asset_host

    if Rails.env.test?
      config.enable_processing = false
    end
  end
end

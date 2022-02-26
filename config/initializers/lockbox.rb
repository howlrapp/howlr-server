Lockbox.master_key = ENV["LOCKBOX_MASTER_KEY"] || Digest::SHA256.hexdigest(Rails.configuration.secret_key_base)

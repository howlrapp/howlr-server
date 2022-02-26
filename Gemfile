source 'https://rubygems.org'

ruby '3.0.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.4.6'
gem 'sprockets', '~> 3.7.2'

# Use postgis as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
gem 'activerecord-postgis-adapter'

# Use Puma as the app server
gem 'puma', '~> 5.0.2'

# Use SCSS for stylesheets
gem 'sassc-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Test stuff
  gem 'rspec-rails', require: false
  gem 'rspec-mocks'

  # Factory classes for testing
  gem 'factory_bot_rails'

  # Generate fake data
  gem 'faker'

  # Env based Configuration
  gem 'figaro'
end

group :test do
  # Code coverage
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.7.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Security policies
gem 'pundit'

# Admin interface and skin
gem 'activeadmin', '~> 2.10.0'
gem 'arctic_admin'

# Authentication for admin interface
gem 'devise', '~> 4.7.3'

# File upload and transsizing
gem "mini_magick"
gem 'carrierwave', '~> 2.2.2'
gem 'carrierwave-base64'
gem 'fog-aws'
gem 'aws-sdk-s3'

# Error handling
gem 'exception_notification'

# Handle login with Telegram
gem 'telegram-bot'

# Utilities for geographic computation and geolocation
gem 'geocoder', '~> 1.6.4'

# GraphQL stuff
gem 'graphql', '>= 1.10.9'

# Send Expo notifications
gem 'exponent-server-sdk'

# Field level encryption
gem 'lockbox'

# Automatically preload relations
gem "ar_lazy_preload"

# Support for postgres functions
gem 'fx'

# To handle websocket connections
gem 'redis'

# Nice graphs on the admin interface
gem "chartkick"
gem "groupdate"

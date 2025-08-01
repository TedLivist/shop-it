source "https://rubygems.org"

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"
gem "devise", "~> 4.9"

gem 'jsonapi-serializer'

gem 'active_model_serializers'
gem 'responders'
# Implement active interaction
gem 'active_interaction', '~> 4.1'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

gem 'aasm', '~> 5.2'
gem 'faker'

# Cloudinary for managing images and media files
gem "cloudinary"

# A pure Ruby implementation of the RFC 7519 OAuth JSON Web Token standard.
gem 'jwt'

# Ruby on Rails API documentation tool
gem 'apipie-rails'

gem "pundit"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop-rails'
  # A Ruby gem to load environment variables from `.env`.
  gem 'dotenv-rails'
  # Annotate Rails classes with schema and routes info
  gem 'annotate'
  # RSpec for Rails 5+
  gem 'rspec-rails', '~> 5.0.0'
  # A library for setting up Ruby objects as test data.
  gem 'factory_bot_rails'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  # Preview mail in the browser instead of sending.
  gem 'letter_opener'

  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  gem 'database_cleaner-active_record'
end



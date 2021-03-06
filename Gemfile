# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 5.1"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "~> 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  gem "rubocop", "~> 1.12", require: false
  gem "rubocop-performance", "~> 1.10", require: false
  gem "solargraph"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Custom list of gems
gem "annotate", "~> 3.1", group: :development
gem "cloudinary", "~> 1.17"
gem "faraday_middleware", "~> 1.0"
gem "feedjira", "~> 3.1"
gem "honeybadger", "~> 4.0"
gem "html_truncator", "~> 0.4"
gem "inline_svg"
gem "nokogiri", "~> 1.11"
gem "pundit", "~> 2.1"
gem "ruby2js", ">= 4.1.3"
# gem "ruby2js", path: "../ruby2js"
gem "serbea", "~> 0.11"
# gem "serbea", path: "../BRIDGETOWN/serbea"
gem "shoulda", "~> 4.0"
gem "sidekiq", "~> 6.1"
gem "sidekiq-cron", "~> 1.2"
gem "turbo-rails"
gem "view_component", "~> 2.18"

gem "acts-as-taggable-on", "~> 7.0"

gem "feedbag", "~> 0.10.1"

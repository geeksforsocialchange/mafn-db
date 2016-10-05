source 'https://rubygems.org'

# API app
gem 'sinatra'
gem "sinatra-activerecord"

# Admin app
gem 'rails', '4.2.0'

# Theming stuff
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

# Database
gem 'pg'
gem 'postgres_ext'

# Fake content
gem 'faker'

# Nicer forms
gem 'formtastic', '~> 3.0'
gem "cocoon"

# To access geolocation API
gem 'rest-client'

# Nice colours for output
gem 'colorize'

# Geo maths
gem 'geokit-rails'

# Excel
gem 'rubyzip', '~> 1.1.0'
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'

# Spreadsheet parser for tests and imports
gem 'roo'
gem 'rqrcode'

# Calendar parsing
gem 'icalendar'

# Users
gem 'devise'

# Pagination / sorting
gem 'smart_listing'
# gem 'will_paginate'

group :production do
  gem 'rails_12factor'
  gem 'puma'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'better_errors'
  gem 'database_cleaner'
  gem 'spring'
  gem 'quiet_assets'
  gem 'guard'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "rails-erd"
  # gem 'livereload'
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'fontello_rails_converter'
end

group :test do
  gem 'sqlite3'
  gem 'guard-minitest'
  gem 'minitest-reporters'
  gem 'minitest-rails-capybara'
  gem 'simplecov', :require => false
end

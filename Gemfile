source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'pg'
gem 'icalendar'
gem 'faker'
# Nicer forms
gem 'formtastic', '~> 3.0'
gem "cocoon"
# Group responses by date
# gem 'groupdate'
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

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'better_errors'
  gem 'database_cleaner'
  gem 'spring'
  gem 'quiet_assets'
  gem 'guard'
  # Spreadsheet parser for tests
  gem 'roo'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "rails-erd"
  # gem 'livereload'
  # gem 'rack-livereload'
  # gem 'guard-livereload'
end

group :test do
  gem 'sqlite3'
  gem 'guard-minitest'
  gem 'minitest-reporters'
  gem 'minitest-rails-capybara'
  gem 'simplecov', :require => false
end

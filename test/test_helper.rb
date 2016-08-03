require 'simplecov'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']

require 'roo'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/rails/capybara'
# require 'devise'

Minitest::Reporters.use!



class ActiveSupport::TestCase

  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods
  include Capybara::DSL
  
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

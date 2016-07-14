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
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
  include Capybara::DSL
  
  # Load spreadsheets from file
  def load_spreadsheet spreadsheet
    visit "/exports/#{spreadsheet}.xlsx"
    File.open("/tmp/#{spreadsheet}.xlsx", 'w') {|f| f.write(page.source) }
    wb = Roo::Excelx.new("/tmp/#{spreadsheet}.xlsx")
    wb.sheet(0)
  end
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user! unless ENV['RAILS_ENV'] = "development"
  WillPaginate.per_page = 50 
end

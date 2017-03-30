class WelcomeController < ApplicationController
  def index
    @events = Event.where.not(latitude: nil)
  end
end

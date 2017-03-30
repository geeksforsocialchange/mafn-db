class WelcomeController < ApplicationController
  def index
    @events = Event.where.not(latitude: nil)
    @members = Member.with_location
  end
end

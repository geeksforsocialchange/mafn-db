class ExportsController < ApplicationController

  def index
  end

  # GET /events
  def events
    @events = Event.all
    respond_to do |format|
      format.xlsx
    end
  end

  def events_demographics
    @events = Event.all
    respond_to do |format|
      format.xlsx
    end
  end

  # GET /members
  def members
    @members = Member.all
    respond_to do |format|
      format.xlsx
    end
  end

end

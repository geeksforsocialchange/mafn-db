class ExportsController < ApplicationController

  def index
  end

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

  def members
    @members = Member.all
    respond_to do |format|
      format.xlsx
    end
  end

  def events_feedback
    @events = Event.all
    respond_to do |format|
      format.xlsx
    end
  end


  def questionnaire
    @members = Member.all
    @initial = params[:initial] == "true" ? true : false
    respond_to do |format|
      format.xlsx
    end
  end

end

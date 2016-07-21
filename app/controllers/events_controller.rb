class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def update_calendar
    flash[:info] = "Import processing. Refresh in a few seconds to see updated results."
    CalendarImportJob.perform_later
    redirect_to action: "index"
  end

  def demographics
    @events = Event.all
    respond_to do |format|
      format.xlsx
    end
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(  :name,
                                      :category,
                                      :start,
                                      :finish,
                                      :location,
                                      :latitude,
                                      :longitude,
                                      :event_type,
                                      :event_type_other,
                                      :description,
                                      :google_id,
                                      attendances_attributes: [
                                        :id,
                                        :event_id,
                                        :member_id,
                                        :_destroy
                                      ])
    end
end

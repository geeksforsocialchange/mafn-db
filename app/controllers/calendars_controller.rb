class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy, :update_event]

  # GET /calendars
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  def show
    @recent_events = Event.where(calendar: @calendar).order("updated_at DESC").limit(10)
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /
  # Iterate calendars and update events in each
  def update_events
    flash[:notice] = "Import processing. Refresh in a few seconds to see updated results."
    calendars = Calendar.all
    calendars.each do |calendar|
      CalendarImportJob.perform_later(calendar)
    end
    redirect_to action: "index"
  end

  def update_event
    flash[:notice] = "Import processing. Refresh in a few seconds to see updated results."
    CalendarImportJob.perform_later(@calendar)
    redirect_to action: "show"
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  def create
    @calendar = Calendar.new(calendar_params)

    if @calendar.save
      redirect_to @calendar, notice: 'Calendar was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /calendars/1
  def update
    if @calendar.update(calendar_params)
      redirect_to @calendar, notice: 'Calendar was successfully updated.'
    else
      render :edit
    end
  end


  # DELETE /calendars/1
  def destroy
    @calendar.destroy
    redirect_to calendars_url, notice: 'Calendar was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calendar_params
      params.require(:calendar).permit(:project_id, :is_funded_default, :url, :region, :log, :has_errors, :last_imported)
    end
end

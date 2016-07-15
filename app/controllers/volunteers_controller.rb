class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  # GET /volunteers
  def index
    @volunteers = Volunteer.all
  end

  # GET /volunteers/1
  def show
  end

  # GET /volunteers/new
  def new
    @volunteer = Volunteer.new
  end

  # GET /volunteers/1/edit
  def edit
  end

  # POST /volunteers
  def create
    @volunteer = Volunteer.new(volunteer_params)

    if @volunteer.save
      redirect_to @volunteer, notice: 'Volunteer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /volunteers/1
  def update
    if @volunteer.update(volunteer_params)
      redirect_to @volunteer, notice: 'Volunteer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /volunteers/1
  def destroy
    @volunteer.destroy
    redirect_to volunteers_url, notice: 'Volunteer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def volunteer_params
      params.require(:volunteer).permit(:role, :is_leader, :start, :finish, :member_id, :project_id)
    end
end

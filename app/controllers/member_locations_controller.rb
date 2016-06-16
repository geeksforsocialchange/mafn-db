class MemberLocationsController < ApplicationController
  before_action :set_member_location, only: [:show, :edit, :update, :destroy]

  # GET /member_locations
  def index
    @member_locations = MemberLocation.all
  end

  # GET /member_locations/1
  def show
  end

  # GET /member_locations/new
  def new
    @member_location = MemberLocation.new
  end

  # GET /member_locations/1/edit
  def edit
  end

  # POST /member_locations
  def create
    @member_location = MemberLocation.new(member_location_params)

    if @member_location.save
      redirect_to @member_location, notice: 'Member location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /member_locations/1
  def update
    if @member_location.update(member_location_params)
      redirect_to @member_location, notice: 'Member location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /member_locations/1
  def destroy
    @member_location.destroy
    redirect_to member_locations_url, notice: 'Member location was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_location
      @member_location = MemberLocation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_location_params
      params.require(:member_location).permit(:member_id, :location_id, :from, :to,
                                                locations_attributes: [
                                                  :id,
                                                  :__destroy,
                                                  :line1,
                                                  :line2,
                                                  :city,
                                                  :postcode
                                                ],
                                              )
    end
end

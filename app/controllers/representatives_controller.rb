class RepresentativesController < ApplicationController
  before_action :set_representative, only: [:show, :edit, :update, :destroy]

  # GET /representatives
  def index
    @representatives = Representative.all
  end

  # GET /representatives/1
  def show
  end

  # GET /representatives/new
  def new
    @representative = Representative.new
  end

  # GET /representatives/1/edit
  def edit
  end

  # POST /representatives
  def create
    @representative = Representative.new(representative_params)

    if @representative.save
      redirect_to @representative, notice: 'Representative was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /representatives/1
  def update
    if @representative.update(representative_params)
      redirect_to @representative, notice: 'Representative was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /representatives/1
  def destroy
    @representative.destroy
    redirect_to representatives_url, notice: 'Representative was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_representative
      @representative = Representative.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def representative_params
      params.require(:representative).permit(:job_title, :start, :finish, :member_id, :organisation_id)
    end
end

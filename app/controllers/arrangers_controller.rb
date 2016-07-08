class ArrangersController < ApplicationController
  before_action :set_arranger, only: [:show, :edit, :update, :destroy]

  # GET /arrangers
  def index
    @arrangers = Arranger.all
  end

  # GET /arrangers/1
  def show
  end

  # GET /arrangers/new
  def new
    @arranger = Arranger.new
  end

  # GET /arrangers/1/edit
  def edit
  end

  # POST /arrangers
  def create
    @arranger = Arranger.new(arranger_params)

    if @arranger.save
      redirect_to @arranger, notice: 'Arranger was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /arrangers/1
  def update
    if @arranger.update(arranger_params)
      redirect_to @arranger, notice: 'Arranger was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /arrangers/1
  def destroy
    @arranger.destroy
    redirect_to arrangers_url, notice: 'Arranger was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arranger
      @arranger = Arranger.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arranger_params
      params.require(:arranger).permit(:project_id, :event_id)
    end
end

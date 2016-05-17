class QuestionResponsesController < ApplicationController
  before_action :set_question_response, only: [:show, :edit, :update, :destroy]

  # GET /question_responses
  def index
    @question_responses = QuestionResponse.all
  end

  # GET /question_responses/1
  def show
  end

  # GET /question_responses/new
  def new
    @question_response = QuestionResponse.new
  end

  # GET /question_responses/1/edit
  def edit
  end

  # POST /question_responses
  def create
    @question_response = QuestionResponse.new(question_response_params)

    if @question_response.save
      redirect_to @question_response, notice: 'Question response was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /question_responses/1
  def update
    if @question_response.update(question_response_params)
      redirect_to @question_response, notice: 'Question response was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /question_responses/1
  def destroy
    @question_response.destroy
    redirect_to question_responses_url, notice: 'Question response was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_response
      @question_response = QuestionResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_response_params
      params.require(:question_response).permit(:response, :entity_id, :member_id)
    end
end

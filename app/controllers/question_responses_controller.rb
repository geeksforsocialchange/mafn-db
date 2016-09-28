class QuestionResponsesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_question_response, only: [:show, :edit, :update, :destroy]

  # GET /question_responses
  def index
    response_scope = QuestionResponse.all
    response_scope = response_scope.like(params[:filter]) if params[:filter]
    @question_responses = smart_listing_create(:question_responses, response_scope, partial: "question_responses/list")
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
    params[:subject] = Entity.find(params[:subject])
    params[:responder] = Member.find(params[:responder])
    params[:question] = Question.find(params[:question])

    @question_response = QuestionResponse.new(question_response_params)

    if @question_response.save
      redirect_to @question_response, notice: 'Question response was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /question_responses/1
  def update
    params = question_response_params
    params[:subject] = Entity.find(params[:subject] || params["question_response"][:subject])
    params[:responder] = Member.find(params[:responder] || params["question_response"][:responder])
    params[:question] = Question.find(params[:question] || params["question_response"][:question])
    if @question_response.update(params)
      redirect_to @question_response, notice: 'Question response was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /question_responses/1
  def destroy
    @question_response.destroy
    if request.env["HTTP_REFERER"]
      redirect_to :back, notice: 'Question response was successfully destroyed.'
    else
      redirect_to question_responses_url, notice: 'Question response was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_response
      @question_response = QuestionResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_response_params
      params.require(:question_response).permit(:response, :subject, :responder, :question)
    end
end

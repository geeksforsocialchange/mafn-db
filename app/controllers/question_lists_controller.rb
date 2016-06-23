class QuestionListsController < ApplicationController
  before_action :set_question_list, only: [:show, :edit, :update, :destroy]

  # GET /question_lists
  def index
    @question_lists = QuestionList.all
  end

  # GET /question_lists/1
  def show
  end

  # GET /question_lists/new
  def new
    @question_list = QuestionList.new
  end

  # GET /question_lists/1/edit
  def edit
  end

  # POST /question_lists
  def create
    @question_list = QuestionList.new(question_list_params)

    if @question_list.save
      redirect_to @question_list, notice: 'Question list was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /question_lists/1
  def update
    if @question_list.update(question_list_params)
      redirect_to @question_list, notice: 'Question list was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /question_lists/1
  def destroy
    @question_list.destroy
    redirect_to question_lists_url, notice: 'Question list was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_list
      @question_list = QuestionList.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_list_params
      params.require(:question_list).permit(:question_id, :question_set_id, :weight)
    end
end

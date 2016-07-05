class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy, :respond]

  # GET /question_sets
  def index
    @question_sets = QuestionSet.all
  end

  # GET /question_sets/1
  def show
    @questions = @question_set.questions
  end

  # GET /question_sets/new
  def new
    @question_set = QuestionSet.new
  end

  # GET /question_sets/1/edit
  def edit
  end


  # Answer a question set
  def respond
    @member = Member.find(params[:member])
  end

  # Remove a question from a question set
  def remove_question
  end

  # POST /question_sets
  def create
    @question_set = QuestionSet.new(question_set_params)

    if @question_set.save
      redirect_to @question_set, notice: 'Question set was successfully created.'
    else
      render :new
    end
  end

  def batch_create
    responder = Member.find(params[:responder].to_i)
    if params[:subject]
      subject = Entity.find(params[:subject].to_i)
    else
      subject = Entity.find(responder.entity_id)
    end
    responses = params["question_set"]["question_response"]

    responses.each do |q,r|
      question = Question.find(q)
      next unless question && r.length > 0
      @response = QuestionResponse.new( responder: responder,
                                        subject: subject,
                                        question: question,
                                        response: r )
      if @response.save!
        puts "Saved!".colorize(:green)
      else
        puts "Not saved!".colorize(:red)
      end
    end
    redirect_to member_path(params[:member])
  end


  # PATCH/PUT /question_sets/1
  def update
    if @question_set.update(question_set_params)
      redirect_to @question_set, notice: 'Question set was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /question_sets/1
  def destroy
    @question_set.destroy
    redirect_to question_sets_url, notice: 'Question set was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_set_params
      params.require(:question_set).permit(
                                      :title,
                                      :member,
                                      :subject,
                                      question_attributes: [
                                        :id, :question, :category,
                                        question_responses_attributes: [
                                          :id, :responder, :subject, :response, :_destroy
                                        ]
                                      ]
                                    )
    end
end

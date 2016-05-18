class AddQuestionRefToQuestionResponse < ActiveRecord::Migration
  def change
    add_reference :question_responses, :question, index: true
    add_foreign_key :question_responses, :questions
  end
end

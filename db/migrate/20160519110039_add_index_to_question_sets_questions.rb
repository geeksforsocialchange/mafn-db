class AddIndexToQuestionSetsQuestions < ActiveRecord::Migration
  def change
    add_index :question_sets_questions, [:question_id, :question_set_id], :unique => true, :name => "question_sets_to_questions"
  end
end

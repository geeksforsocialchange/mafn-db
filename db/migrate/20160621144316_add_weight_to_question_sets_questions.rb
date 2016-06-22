class AddWeightToQuestionSetsQuestions < ActiveRecord::Migration
  def change
    add_column :question_sets_questions, :weight, :integer
  end
end

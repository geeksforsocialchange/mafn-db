class DropQuestionsQuestionSets < ActiveRecord::Migration
  def change
    drop_join_table :questions, :question_sets
  end
end

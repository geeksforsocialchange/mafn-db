class JoinQuestionsAndQuestionSets < ActiveRecord::Migration
  def change
    create_join_table :questions, :question_sets
  end
end

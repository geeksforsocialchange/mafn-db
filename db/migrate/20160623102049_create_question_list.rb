class CreateQuestionList < ActiveRecord::Migration
  def change
    create_table :question_lists do |t|
      t.references :question, index: true
      t.references :question_set, index: true
      t.integer :weight
    end
    add_foreign_key :question_lists, :questions
    add_foreign_key :question_lists, :question_sets
  end
end

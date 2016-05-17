class CreateQuestionSets < ActiveRecord::Migration
  def change
    create_table :question_sets do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end

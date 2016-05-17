class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question, null: false
      t.string :response

      t.timestamps null: false
    end
  end
end

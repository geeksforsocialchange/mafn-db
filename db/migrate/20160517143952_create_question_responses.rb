class CreateQuestionResponses < ActiveRecord::Migration
  def change
    create_table :question_responses do |t|
      t.string :response
      t.references :entity, index: true
      t.references :member, index: true

      t.timestamps null: false
    end
    add_foreign_key :question_responses, :entities
    add_foreign_key :question_responses, :members
  end
end

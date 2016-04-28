class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :category
      t.datetime :date
      t.string :description

      t.timestamps null: false
    end
  end
end

class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.string :tel
      t.string :mob
      t.string :email

      t.timestamps null: false
    end
  end
end

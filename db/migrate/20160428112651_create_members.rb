class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.string :tel
      t.string :mob
      t.string :email

      t.timestamps null: false
    end
  end
end

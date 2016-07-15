class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :role
      t.boolean :is_leader
      t.date :start
      t.date :finish
      t.references :member, index: true
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :volunteers, :members
    add_foreign_key :volunteers, :projects
  end
end

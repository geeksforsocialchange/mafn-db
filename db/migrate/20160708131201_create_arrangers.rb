class CreateArrangers < ActiveRecord::Migration
  def change
    create_table :arrangers do |t|
      t.references :project, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
    add_foreign_key :arrangers, :projects
    add_foreign_key :arrangers, :events
  end
end

class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :member, index: true
      t.references :event, index: true

      t.timestamps null: false
    end
    add_foreign_key :attendances, :members
    add_foreign_key :attendances, :events
  end
end

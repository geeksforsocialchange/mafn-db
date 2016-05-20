class CreateMemberLocations < ActiveRecord::Migration
  def change
    create_table :member_locations do |t|
      t.references :member, index: true
      t.references :location, index: true
      t.date :from
      t.date :to

      t.timestamps null: false
    end
    add_foreign_key :member_locations, :members
    add_foreign_key :member_locations, :locations
  end
end

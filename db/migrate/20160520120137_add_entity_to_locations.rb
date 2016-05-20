class AddEntityToLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :entity, index: true
    add_foreign_key :locations, :entities
  end
end

class AddEntityRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :entity, index: true
    add_foreign_key :events, :entities
  end
end

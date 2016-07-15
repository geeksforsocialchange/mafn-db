class AddEntityToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :entity, index: true
    add_foreign_key :projects, :entities
  end
end

class AddEntityRefToMembers < ActiveRecord::Migration
  def change
    add_reference :members, :entity, index: true
    add_foreign_key :members, :entities
  end
end

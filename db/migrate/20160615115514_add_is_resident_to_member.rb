class AddIsResidentToMember < ActiveRecord::Migration
  def change
    add_column :members, :is_resident, :boolean
  end
end

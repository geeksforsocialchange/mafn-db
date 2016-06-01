class AddRegionToMember < ActiveRecord::Migration
  def change
    add_column :members, :region, :integer
  end
end

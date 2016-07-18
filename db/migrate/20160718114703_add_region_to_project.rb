class AddRegionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :region, :integer
  end
end

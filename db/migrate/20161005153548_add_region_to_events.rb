class AddRegionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :region, :integer
  end
end

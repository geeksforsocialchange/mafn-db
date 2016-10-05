class FixDefaultRegionName < ActiveRecord::Migration
  def change
    rename_column :calendars, :region_default, :region
  end
end

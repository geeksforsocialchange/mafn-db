class RenameEventStart < ActiveRecord::Migration
  def change
    rename_column :events, :date, :start
  end
end

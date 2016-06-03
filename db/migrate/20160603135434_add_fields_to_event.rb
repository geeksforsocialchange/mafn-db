class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :end, :datetime
    add_column :events, :google_id, :string
    add_column :events, :location, :string
  end
end

class AddTypeOtherToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_type_other, :string
  end
end

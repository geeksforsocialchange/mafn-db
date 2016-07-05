class AddTypeOtherToEvent < ActiveRecord::Migration
  def change
    add_column :events, :type_other, :string
  end
end
